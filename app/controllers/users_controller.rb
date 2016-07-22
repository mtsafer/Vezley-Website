class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def show
		@user = User.find_by_id params[:id]
		redirect_to root_url and return unless @user.activated?
		if !logged_in?
			flash[:warning] = "You must be logged in to view your profile"
			redirect_to root_path
	  elsif current_user != @user
				flash[:warning] = "You can only view your own profile"
				redirect_to root_path
		end
	end

	def create
		@user = User.new user_params
		@user.mod = 0
		@user.owner = 0
		if @user.save
			@user.send_activation_email
      message = "Please check your email to activate your account."
      message += " This may take a minute, please be patient."
      flash[:info] = message
      redirect_to root_url
		else
			render :new
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
