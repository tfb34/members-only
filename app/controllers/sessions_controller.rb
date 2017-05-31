class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email])
  	if @user && @user.authenticate(params[:session][:password]) # found
  		flash[:success]= "You are now logged in."
  		log_in @user
  		redirect_to @user
  	else
  		flash.now[:error] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	#must delete user if logged in
    logout if logged_in?
  	if current_user != nil
  	    cookies.delete :remember_token
  	    session[:user_id] = nil
  	    current_user.forget
  	end
  	redirect_to root_url
  end
end
