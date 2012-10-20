class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :diary_id
      t.string :tag_body

      t.timestamps
    end
  end
end
