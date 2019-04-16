module RedmineTextBlocks
  module IssueStatusPatch
    def self.apply
      IssueStatus.class_eval do
        has_and_belongs_to_many :text_blocks
      end
    end
  end
end
