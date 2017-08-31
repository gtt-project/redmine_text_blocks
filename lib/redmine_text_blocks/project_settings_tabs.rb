module RedmineTextBlocks

  # hooks into the helper method that renders the project settings tabs
  module ProjectSettingsTabs

    def project_settings_tabs
      super.tap do |tabs|
        if User.current.allowed_to?(:manage_text_blocks, @project)
          tabs << {
            name: 'text_blocks',
            action: :manage_text_blocks,
            partial: 'projects/settings/text_blocks',
            label: :label_text_block_plural
          }
        end
      end
    end

  end
end

