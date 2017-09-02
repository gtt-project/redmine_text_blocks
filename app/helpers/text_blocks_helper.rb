module TextBlocksHelper
  def text_block_options
    tags = []
    tags << content_tag(:option, value: '') do
      t('label_select_text_block')
    end
    tags += TextBlock.where(project_id: [nil, @project.id]).to_a.map{|tb|
      content_tag :option, value: tb.text do
        tb.name
      end
    }
    safe_join tags
  end
end
