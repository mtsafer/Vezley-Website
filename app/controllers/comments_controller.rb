class CommentsController < ApplicationController

	def new
		@comment = Comment.new
		@subject = params[:subject]
		@id = params[:id]
	end

	def create
		if logged_in?
			@comment = Comment.new comment_params
			@comment.user_id = current_user.id
			@comment.post_id = params[:id]
			if @comment.save
				flash[:success] = "Comment posted"
				redirect_to "/forum/#{params[:subject]}/#{params[:id]}"
			else
				render :new
			end
		else
			flash[:warning] = "You must be logged in to post on the forum"
	    redirect_to login_path # halts request cycle
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:body)
		end

end
