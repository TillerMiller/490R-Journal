class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    # for debug
    # @provider = omniauth['provider']
    # @uid = omniauth['uid']
    # @email = omniauth['info']['email']
    # @auth_yaml = omniauth.to_yaml
    # raise request.env["omniauth.auth"].to_yaml

    @authentication = Authentication.where(uid:  omniauth['uid'], provider: omniauth['provider']).first
    if @authentication
      #already have the authentication, sign in the user
      session[:user_id] = @authentication.user.id
      redirect_to root_url, notice: "Sign in succesfull!"
    elsif current_user
      #user logged in, add the authenticaiton
      @authentication = current_user.authentications.build
      @authentication.provider = omniauth['provider']
      @authentication.uid = omniauth['uid']
      @authentication.save!
      redirect_to root_url, notice: "Authentication succesfull"
    else
      #new user, add user and authentication
      @user = User.new
      @user.email = omniauth['info']['email']
      @user.password_digest = 0
      @authentication = @user.authentications.build
      @authentication.provider = omniauth['provider']
      @authentication.uid =  omniauth['uid']
      @user.save!
      @authentication.save!
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Signed up succesfully!"
    end
  end
  
  def index
    @user = current_user
    @authentications = current_user.authentications if current_user
  end

  def failure
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    if @authentication.destroy
      redirect_to user_authentications_path current_user, notice: "Successfully destroyed authentication."
    else
      redirect_to root_path, notice: "Deletion failed" 
    end
  end
end