class Tags < ActiveRecord::Base
  attr_accessible :diary_id, :tag_body
  belongs_to :diary
end
