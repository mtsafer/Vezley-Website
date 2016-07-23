class UsersController < ApplicationController

	def index
		@users = User.where(activated: true, banned: false).paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find params[:id]
	end

	def update
		@user = User.find params[:id]
		if current_user && current_user == @user
			if @user.update user_params
				flash[:success] = "Profile updated"
				redirect_to user_path(@user)
			else
				render :edit
			end
		else
			flash[:danger] = "You can not edit someone else's profile"
			redirect_to root_url
		end
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

	def ban
		@user = User.find params[:id]
		if current_user && current_user.mod == 1
			@user.banned = true
			@user.save
			flash[:success] = "#{@user.name} has been banned. PURGE THE REBEL SCUM!"
			redirect_to users_path
		else
			flash[:warning] = "Only mods can ban users."
			redirect_to root_url
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
