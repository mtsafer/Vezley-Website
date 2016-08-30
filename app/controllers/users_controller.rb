class UsersController < ApplicationController

	def index
		if !logged_in?
			flash[:warning] = "You must be logged in to view a profile"
			redirect_to root_path
		else
			@users = User.where(banned: false).order("LOWER(name)").paginate(page: params[:page])
		end
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find params[:id]
		@status = @user.status
	end

	def update
		@user = User.find params[:id]
		if current_user && current_user == @user
			if @user.allow_or_deny_custom_status || params[:user][:custom_status] == @user.status || params[:user][:custom_status].empty?
				if params[:user][:custom_status].empty?	
					if @user.update user_params_without_custom_status
						flash[:success] = "Profile updated"
						redirect_to user_path(@user)
					else
						render :edit
					end
				else
					if @user.update user_params
						flash[:success] = "Profile updated"
						redirect_to user_path(@user)
					else
						render :edit
					end
				end
			else
				flash[:danger] = "You must construct additional pylons!"
				render :edit
			end
		else
			flash[:danger] = "You can not edit someone else's profile"
			redirect_to root_url
		end
	end

	def show
		@user = User.find_by_id params[:id]
		#redirect_to root_path and return unless @user.activated?
		if !logged_in?
			flash[:warning] = "You must be logged in to view a profile"
			redirect_to root_url
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
			redirect_to users_url
		else
			flash[:warning] = "Only mods can ban users."
			redirect_to root_url
		end
	end

	def mod
		@user = User.find params[:id]
		if current_user && current_user.owner == 1
			@user.mod = 1
			@user.save
			flash[:success] = "#{@user.name} has been made a mod"
			redirect_to users_url
		else
			flash[:warning] = "Only the owner can give mod privileges"
			redirect_to root_url
		end
	end

	def unmod
		@user = User.find params[:id]
		if current_user && current_user.owner == 1
			@user.mod = 0
			@user.save
			flash[:success] = "#{@user.name} no longer has mod privileges"
			redirect_to users_url
		else
			flash[:warning] = "Only the owner can remove mod privileges"
			redirect_to root_url
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password,
										 :password_confirmation, :public_profile, :custom_status)
		end

		def user_params_without_custom_status
			params.require(:user).permit(:name, :email, :password,
										 :password_confirmation, :public_profile)
		end

end
