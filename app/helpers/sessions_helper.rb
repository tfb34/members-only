module SessionsHelper
  def log_in(user)
  	user.remember_token = User.new_token
  	cookies.permanent[:remember_token] = user.remember_token
  	#cookies.permanent.signed[:user_id] = user.id
  	session[:user_id] = user.id
  	user.update_attributes(remember_digest: User.digest(user.remember_token))
  	@current_user = user
  end	
  
  def current_user?(user)
      user == current_user
  end

  #Retrieves current user else returns nil
  def current_user
  	user_id = session[:user_id]
  	user = User.find_by(id: user_id)
  	token = cookies.permanent[:remember_token]
  	
  	if user_id#if theres a user_id then it means that user has logged_in already
  		@current_user ||= user
  	elsif user && token && user.authenticated?("remember",token)
  		@current_user = user
  	else
  		@current_user = nil
  	end

  end
  #returns true if user is logged in, false otherwise
  def logged_in?
  	!current_user.nil?
  end

  def log_out
    forget(current_user)
  	cookies.delete :remember_token
  	session[:user_id] = nil
  	@current_user = nil
  end

  def forget(user)
    user.forget
  end
end
