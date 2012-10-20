class User < ActiveRecord::Base
	has_secure_password
	attr_accessible :email, :password, :password_confirmation, :name
	validates_presence_of :email
	has_many :diaries, :dependent => :destroy
end
