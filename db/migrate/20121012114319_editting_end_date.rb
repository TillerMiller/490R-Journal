class EdittingEndDate < ActiveRecord::Migration
  def up
  	change_column :diaries, :end_date, :date
  end

  def down
  	
  end
end
