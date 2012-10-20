class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :title
      t.date :start_date
      t.string :end_date
      t.integer :user_id

      t.timestamps
    end
  end
end
