class TextBlocksController < ApplicationController

  before_action :find_project_by_project_id

  before_action :require_admin, if: ->{ @project.nil? }
  before_action :authorize,     if: ->{ @project.present? }

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
      if params[:continue]
        redirect_to new_path
      else
        redirect_to index_path
      end
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
    @project ? project_text_blocks_path(@project) : text_blocks_path
  end

  def text_block_params
    params[:text_block].permit :name, :text
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
    text_blocks = TextBlock.order(name: :asc)
    if @project
      text_blocks = text_blocks.where(project_id: @project.id)
    end
    text_blocks
  end

end
