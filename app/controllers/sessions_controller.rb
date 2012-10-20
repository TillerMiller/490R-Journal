class SessionsController < ApplicationController
	
	def new
		if current_user
			redirect_to user_path current_user, flash.keep(:notice) 
		end
 	end
  
	def create
		user = User.where(:email => params[:email]).first
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_path = session[:protected_page] ? session[:protected_page] : user_path(current_user)
			session[:protected_page] = nil
			redirect_to redirect_path, :notice => "Logged In"
		else
			flash.now.alert = 'Incorrect Email/Password'
			render :new
		end
	end
  
	def destroy
		session[:user_id] = nil
		redirect_to root_path, :notice => 'Logged Out'
	end
end
