class ApplicationController < ActionController::Base
	protect_from_forgery

	private

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user

	def authenticate
		unless current_user
			session[:protected_page] = request.fullpath
			redirect_to login_path, :notice => 'You must login to perform that action.'
		end
	end

	def authorize
	end
	
end
