class TagsController < ApplicationController

	def new
		@tag = Tag.new
	end

	def create
		@diary = Diary.find params[:diary_id]
		@tag = Tag.new(params[:user])
		@tag.diary_id = params[:diary_id]
		if @tag.save
			redirect_to @diary, :notice => "Tag was saved."
		else
			render :new
		end
	end

	def edit
		@tag = Tag.find params[:diary_id]
	end

	def update
		@diary = Diary.find params[:diary_id]
		@tag = Tag.find @diary.id
		if @tag.update_attributes(params[:user])
			redirect_to @tag, :notice => "Tag updated."
		else
			render :edit
		end
	end

	def destroy
		@tag = Tag.find parms[:diary_id]
		@diary = Diary.find parms[:diary_id]
		if session[:user_id] != @diary.user_id then
			redirect_to @tag, :notice => "You can't delete other people's tags."
		else
			@tag.destroy
			redirect_to users_path current_user , :notice => 'Tag Deleted.'
		end
	end
end