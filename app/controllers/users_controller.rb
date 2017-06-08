class UsersController < ApplicationController

  def new
  end

  def show
  	@user = User.find_by(id: params[:id])
  end

  def create
  	#create a user
  	user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
  	if user.save
  		log_in(user)
  		redirect_to user# action show
  	else
  		flash.now[:error] = user.errors.full_messages.to_s
  		render 'new'
  	end
  end

  private


end
