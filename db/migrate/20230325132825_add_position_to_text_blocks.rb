class AddPositionToTextBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :text_blocks, :position, :integer
    # # After executing "rake redmine:plugins:migrate", execute the following on "rails console", if keeping the existing positions is important:
    # res = TextBlock.connection.select_all("SELECT id, name, project_id, row_number() over(PARTITION by project_id) AS position FROM #{TextBlock.table_name}")
    # res.rows.each{|row| TextBlock.connection.execute("UPDATE #{TextBlock.table_name} SET position=#{row[3]} WHERE id=#{row[0]}")}
  end
end
