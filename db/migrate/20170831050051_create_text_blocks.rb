class CreateTextBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :text_blocks do |t|
      t.string :name
      t.text :text
      t.references :project, index: true, foreign_key: true, type: :integer

      t.timestamps null: false
    end
  end
end
