class AddPositionToTextBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :text_blocks, :position, :integer, :default => 1
  end
end
