class PostsController < ApplicationController

	def show
		@post = Post.find_by_id params[:id]
	end

	def new
		@post = Post.new
		@subject = params[:subject]
	end

	def create
		@post = Post.new post_params
		@post.user_id = current_user.id
		@post.subject_id = Subject.find_by_name(params[:subject]).id
		if @post.save
			flash[:success] = "New Thread Created"
			redirect_to "/forum/#{params[:subject]}/#{@post.id}"
		else
			render :new
		end
	end

	private

		def post_params
			params.require(:post).permit(:title,:body)
		end

end
