require 'redmine_text_blocks/hooks'


module RedmineTextBlocks
  def self.setup
    ProjectsController.send :helper, RedmineTextBlocks::ProjectSettingsTabs
  end
end
