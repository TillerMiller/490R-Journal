class AddDiaryIdColumnToEntries < ActiveRecord::Migration
  def change
  	add_column :entries, :diary_id, :integer, :default => 1
  end
end
