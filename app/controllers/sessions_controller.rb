class SessionsController < ApplicationController
  def new
  
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		flash[:success] = "Welcome, #{user.name}, to the Vezzelution!"
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_to root_path
  	else
  		flash.now[:danger] = "The email password combination did not match."
  		render :new
  	end
  end

  def destroy
  	flash[:success] = "You have been logged out"
  	logout if logged_in?
  	redirect_to root_path
  end
end
