class Diary < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :title, :user_id
  validates :title, :presence => true
  has_many :entries, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  belongs_to :user
end
