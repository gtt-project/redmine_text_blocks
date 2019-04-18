class CreateJoinTableIssueStatusTextBlocks < ActiveRecord::Migration[5.2]
  def change
    create_join_table :issue_statuses, :text_blocks do |t|
      # t.index [:issue_status_id, :text_block_id]
      # t.index [:text_block_id, :issue_status_id]
    end
  end
end
