class EntriesController < ApplicationController
		
	def index
		@diary = Diary.find params[:diary_id]
		@entries = Entry.order().page(params[:page])
	end

	def show
		@entry = Entry.find params[:id]
	end

	def new
		@diary = Diary.find params[:diary_id]
		@entry = Entry.new
	end

	def create
		@diary = Diary.find params[:diary_id]		
		@entry = Entry.new params[:entry]
	  	if @diary.entries << @entry
	  		redirect_to @diary, :notice => "Entry Created"
	  	else
	  		render :new, :notice => "problem"
	  	end
	end

	def edit
    	@diary = Diary.find params[:diary_id]
    	@entry = Entry.find params[:id]
	end

	def update
		@diary = Diary.find params[:diary_id]		
		@entry = @diary.entries.find(params[:id])
		if @entry.update_attributes(params[:entry])
        	redirect_to @diary, :notice => 'Entry was successfully updated.'
    	else
    		render action: "edit"
    	end
	end

	def destroy
		@diary = Diary.find params[:diary_id]
		@entry = @diary.entries.find params[:id]
		@diary.entries.destroy(@entry)
		redirect_to @diary, :notice => 'Entry Deleted'
	end
end