class TextBlocksController < ApplicationController
  layout ->{ @project ? 'base' : 'admin' }

  self.main_menu = false

  before_action :find_project_by_project_id
  before_action :get_issue_statuses, except: [:index, :destroy]

  before_action :require_admin, if: ->{ @project.nil? }
  before_action :authorize,     if: ->{ @project.present? }

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
      redirect_to index_path
    else
      render 'edit'
    end
  end

  def destroy
    find_text_block.destroy
    redirect_to index_path
  end


  private

  def new_path
    @project ? new_project_text_block_path(@project) : new_text_block_path
  end

  def index_path
    @project ? settings_project_path(@project, tab: 'text_blocks') : text_blocks_path
  end

  def text_block_params
    params[:text_block].permit :name, :text, :issue_status_ids => []
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
    TextBlock.order(name: :asc).where(project_id: @project&.id)
  end

  def get_issue_statuses
    @issue_statuses = IssueStatus.all.sorted
  end
end
