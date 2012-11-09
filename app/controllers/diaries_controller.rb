class DiariesController < ApplicationController
	before_filter :authenticate, :except => [:index, :show]

	def new
		@diary = Diary.new
	end

	def create
		@diary = Diary.new(params[:diary])
	  	@diary.user_id = current_user.id
	  	if @diary.save
	  		redirect_to @diary, :notice => "Journal Created"
	  	else
	  		render :new
	  	end
	end

	def index
		@diaries = Diary.order().page(params[:page]).per(1)
	end

	def show
		@diary = Diary.find params[:id]
		if @diary.user_id != session[:user_id]
			redirect_to root_path, :notice => "Not allowed to read someone else's journal"
		end
	end

	def edit
		@diary = Diary.find params[:id]
		if @diary.user_id != session[:user_id]
			redirect_to root_path, :notice => "Edit your own Journal!!!"
		end
	end

	def update
		@diary = Diary.find params[:id]
		if @diary.user_id == session[:user_id]
			if @diary.update_attributes(params[:diary])
				redirect_to @diary, :notice => "Journal Updated"
			else
				render :edit
			end
		else
			redirect_to root_path, :notice => "Edit your own Journal!!!"
		end
	end

	def destroy
			@diary = Diary.find params[:id]
		if @diary.user_id == session[:user_id]
			@diary.destroy
			redirect_to diaries_path, :notice => 'Diary deleted.'
		else
			redirect_to root_path, :notice => "Naughty Naughty!!!"
		end	
	end
end