module RedmineTextBlocks
  module ProjectPatch
    def self.apply
      Project.class_eval do
        has_many :text_blocks, dependent: :delete_all
      end
    end
  end
end
