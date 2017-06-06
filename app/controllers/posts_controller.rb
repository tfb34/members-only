class PostsController < ApplicationController
  #before_action :sign_in, only: [:new, :create] 
  def new
  end

  def create
  	if (@user = current_user)
  		post = Post.create!(text: params[:post][:message].chomp, user_id: current_user.id)
  	   	render 'index'
  	else
  		flash[:error] = "User could not be found."
  	    redirect_to login_path
  	end
  	#flash[:error] = "User could not be found."
  	#redirect_to login_path
  end

  def index
  	@posts = Post.all
  end

  private

  def sign_in
  	unless logged_in?
  		flash[:danger] = "Please log in."
  		redirect_to login_path
  	end
  end
end
