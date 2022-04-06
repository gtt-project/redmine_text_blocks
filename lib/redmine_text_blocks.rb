module RedmineTextBlocks
  def self.setup
    RedmineTextBlocks::ProjectPatch.apply
    RedmineTextBlocks::IssueStatusPatch.apply
    ProjectsController.send :helper, RedmineTextBlocks::ProjectSettingsTabs
    IssuesController.send :helper, TextBlocksHelper
  end
end
