class TextBlocksController < ApplicationController
  layout ->{ @project ? 'base' : 'admin' }

  self.main_menu = false

  before_action :find_project_by_project_id
  before_action :get_issue_statuses, except: [:index, :destroy]

  before_action :require_admin, if: ->{ @project.nil? } , except: :blocks_by_status
  before_action :authorize,     if: ->{ @project.present? }, except: :blocks_by_status

  menu_item :settings, only: [:new, :create, :edit, :update, :destroy]
  helper_method :index_path

  def index
    @text_blocks = text_block_scope
  end

  def edit
    @text_block = find_text_block
  end

  def new
    @text_block = TextBlock.new
  end

  def create
    r = RedmineTextBlocks::SaveTextBlock.(text_block_params,
                                          project: @project)
    if r.text_block_saved?
      redirect_to params[:continue] ? new_path : index_path
    else
      @text_block = r.text_block
      render 'new'
    end
  end

  def update
    @text_block = find_text_block
    r = RedmineTextBlocks::SaveTextBlock.(text_block_params,
                                          text_block: @text_block)
    if r.text_block_saved?
      respond_to do |format|
        format.html {
          flash[:notice] = l(:notice_successful_update)
          redirect_to index_path
        }
        format.js { head 200 }
      end
    else
      respond_to do |format|
        format.html {
          render 'edit'
        }
        format.js { head 422 }
      end
    end
  end

  def destroy
    find_text_block.destroy
    redirect_to index_path
  end

  def blocks_by_status
    @txtblocks = get_blocks_by_status(params[:status_id])
    respond_to do |format|
      format.json { render json: @txtblocks.to_json }
    end
  end

  private

  def new_path
    @project ? new_project_text_block_path(@project) : new_text_block_path
  end

  def index_path
    @project ? settings_project_path(@project, tab: 'text_blocks') : text_blocks_path
  end

  def text_block_params
    params[:text_block].permit :name, :text, :issue_status_ids, :position
  end

  def find_text_block
    text_block_scope.find params[:id]
  end

  def find_project_by_project_id
    if id = params[:project_id]
      @project = Project.find id
    end
  end

  def text_block_scope
    TextBlock.where(project_id: @project&.id).sorted
  end

  def get_issue_statuses
    @issue_statuses = IssueStatus.all.sorted
  end

  def get_blocks_by_status(status_id)
    IssueStatus.find(status_id).text_blocks.blank? ? text_block_scope : IssueStatus.find(status_id).text_blocks.where(project_id: [nil, @project&.id]).sorted
  end
end
