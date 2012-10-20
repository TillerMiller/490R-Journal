class Entry < ActiveRecord::Base
	attr_accessible :date, :entry, :title
  	validates_presence_of :date, :entry
  	belongs_to :diary
end