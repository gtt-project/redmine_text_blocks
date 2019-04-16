module TextBlocksHelper
  def text_block_options(issue=nil)
    tags = []
    tags << content_tag(:option, value: '') do
      t('label_select_text_block')
    end
    status_textblocks = IssueStatus.find(issue.status_id).text_blocks
    if issue and status_textblocks
      status_id = issue.status_id
      tags += status_textblocks.map{|tb|
        content_tag :option, value: tb.text do
          tb.name
        end
      }
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
