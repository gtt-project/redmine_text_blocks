class CreateTextBlocks < ActiveRecord::Migration
  def change
    create_table :text_blocks do |t|
      t.string :name
      t.text :text
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
