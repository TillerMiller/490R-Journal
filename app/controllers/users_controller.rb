class UsersController < ApplicationController
	before_filter :authenticate, :except => [:index, :show, :new, :create]

	def index
		@users = User.all
	end

	def show
		@user = User.find current_user
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(session[:user_id]), :notice => "Welcome #{@user.email}."
		else
			render :new
		end
	end

	def edit
		@user = User.find current_user
	end

	def update
		@user = User.find params[:id]
		if @user.update_attributes(params[:user])
			redirect_to @user, :notice => "Profile updated."
		else
			render :edit
		end
	end

	def destroy
		@user = User.find current_user
		id = :id
		if id != @user.id then
			redirect_to @user, :notice => "You can't delete other users #{id}."
		else
			@user.destroy
			session[:user_id] = nil
			redirect_to users_path current_user , :notice => 'Profile Deleted.'
		end
	end
end