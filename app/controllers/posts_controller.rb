class PostsController < ApplicationController

	def show
		@post = Post.find_by_id params[:id]
	end

	def new
		@post = Post.new
		@subject = params[:subject]
	end

	def create
		if logged_in?	
			@post = Post.new post_params
			@post.user_id = current_user.id
			@post.subject_id = Subject.find_by_name(params[:subject]).id
			if @post.save
				flash[:success] = "New Thread Created"
				redirect_to "/forum/#{params[:subject]}/#{@post.id}"
			else
				render :new
			end
		else
			flash[:warning] = "You must be logged in to post on the forum"
	    redirect_to login_path # halts request cycle
		end
	end

	def edit
		@post = Post.find_by_id params[:id]
	end

	def update
		@post = Post.find_by_id params[:id]
		if current_user == @post.user || current_user.mod == 1
			if @post.update post_params
				flash[:success] = "Updated"
				redirect_to "/forum/#{@post.subject.name}/#{@post.id}"
			else
				render :edit
			end
		else
			flash[:warning] = "You may only edit your own threads!"
			redirect_to forum_path
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if current_user == @post.user || current_user.mod == 1
	    flash[:success] = "Thread has been deleted!"
	    @post.destroy
	  else
	  	flash[:warning] = "You may only delete your own threads!"
	  end
    redirect_to forum_path
	end

	private

		def post_params
			params.require(:post).permit(:title,:body)
		end

end
