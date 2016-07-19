class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.new comment_params
		@comment.user_id = current_user.id
		@comment.post_id = params[:id]
		if @comment.save
			flash[:success] = "Comment posted"
			redirect_to "/forum/#{params[:subject]}/#{params[:id]}"
		else
			render :new
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:body)
		end

end
