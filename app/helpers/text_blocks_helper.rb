module TextBlocksHelper
  def text_block_options(issue=nil)
    tags = []
    tags << content_tag(:option, value: '') do
      t('label_select_text_block')
    end
    if issue
      status_id = issue.status_id.to_s
      txtblock_settings = Setting.plugin_redmine_text_blocks["textblock_config"][status_id]
      if txtblock_settings
        tags += TextBlock.where(project_id: [nil, @project.id]).to_a.map{|tb|
          content_tag :option, value: tb.text do
            tb.name
          end if txtblock_settings.include?(tb.id.to_s)
        }
      end
    else
      tags += TextBlock.where(project_id: [nil, @project.id]).to_a.map{|tb|
        content_tag :option, value: tb.text do
          tb.name
        end
      }
    end
    safe_join tags
  end
end
