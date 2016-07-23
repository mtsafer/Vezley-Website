class PostsController < ApplicationController

	def show
		@post = Post.find_by_id params[:id]
		@posts = Comment.where(post_id: @post.id).paginate(page: params[:page],
																									 per_page: 10)
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
			if @post.closed == 1
				flash[:warning] = "This thread is closed and can not be edited"
				redirect_to "/forum/all"
			elsif @post.update post_params
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
    redirect_to "/forum/all"
	end

	def sticky
		if current_user.mod == 1
			post = Post.find params[:id]
			post.sticky = params[:sticky]
			post.save
			flash[:success] = ((post.sticky == 1) ? "Ewwww, why is this thread all sticky?" : "This thread is no longer sticky")
		else
			flash[:warning] = "Only mods can make threads sticky"
		end
		redirect_to "/forum/all"
	end

	def move
		@post = Post.find params[:id]
		@subjects = Subject.all
	end

	def move_update
		if current_user.mod == 1	
			@post = Post.find params[:id]
			@post.subject = Subject.find_by_name params[:post][:subject]
			@post.save
			flash[:success] = "Thread has been moved"
		else
			flash[:warning] = "Only mods can move threads"
		end
		redirect_to "/forum/all"
	end

	def close
		if current_user.mod == 1
			post = Post.find params[:id]
			update_save = post.updated_at
			post.closed = params[:closed]
			post.save
			post.updated_at = update_save
			post.save
			flash[:success] = ((post.closed == 1) ? "Post closed" : "Post opened")
		else
			flash[:warning] = "Only mods can close or open posts"
		end
		redirect_to "/forum/all"
	end

	private

		def post_params
			params.require(:post).permit(:title,:body)
		end

end
