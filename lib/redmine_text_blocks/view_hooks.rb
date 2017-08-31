module RedmineTextBlocks
  class ViewHooks < Redmine::Hook::ViewListener

    render_on :view_issues_edit_notes_bottom,
      partial: 'hooks/text_blocks/view_issues_edit_notes_bottom'

  end
end
