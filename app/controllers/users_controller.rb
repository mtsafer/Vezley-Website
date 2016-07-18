class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def show
		@user = User.find_by_id params[:id]
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
		if @user.save
			flash[:success] = "Welcome to the Vezzelution"
			redirect_to root_path
		else
			render :new
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
