module RedmineTextBlocks
  class ViewHooks < Redmine::Hook::ViewListener

    render_on :view_issues_edit_notes_bottom,
      partial: 'hooks/text_blocks/view_issues_edit_notes_bottom'

    render_on :view_layouts_base_html_head, inline: <<-END
        <%= stylesheet_link_tag 'text_blocks', plugin: 'redmine_text_blocks' %>
    END
  end
end
