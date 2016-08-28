class CommentsController < ApplicationController

	def new
		if logged_in?
			@comment = Comment.new
			@subject = params[:subject]
			@id = params[:id]
		else
			flash[:warning] = "You must be logged in to post on the forum"
	    redirect_to "/forum/#{params[:subject]}/#{params[:id]}"
		end
	end

	def create
		if logged_in?
			@comment = Comment.new comment_params
			@comment.user_id = current_user.id
			@comment.post_id = params[:id]
			if @comment.post.closed == 1
				flash[:warning] = "This thread is closed and can not be commented on"
				redirect_to "/forum/#{params[:subject]}/#{params[:id]}"
			elsif @comment.save
				flash[:success] = "Comment posted"
				@comment.post.updated_at = Time.now
				@comment.post.save
				redirect_to "/forum/#{params[:subject]}/#{params[:id]}"
			else
				render :new
			end
		else
			flash[:warning] = "You must be logged in to post on the forum"
	    redirect_to "/forum/#{params[:subject]}/#{params[:id]}"
		end
	end

	def edit
		@comment = Comment.find params[:id]
		@subject = Subject.find_by_name params[:subject]
	end

	def update
		@comment = Comment.find params[:id]
		if @comment.user == current_user || current_user.mod == 1
			if @comment.post.closed == 1
				flash[:warning] = "This thread is closed and can not be edited"
				redirect_to "/forum/#{params[:subject]}/#{@comment.post.id}"
			elsif @comment.update comment_params
				flash[:success] = "Comment has been updated!"
				@comment.post.updated_at = Time.now
				@comment.post.save
				redirect_to "/forum/#{params[:subject]}/#{@comment.post.id}"
			else
				render :edit
			end
		else
			flash[:success] = "You may only edit your own comments!"
			redirect_to "/forum/#{params[:subject]}/#{@comment.post.id}"
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		if current_user == @comment.user || current_user.mod == 1
	    flash[:success] = "Comment has been deleted!"
	    @comment.destroy
	  else
	  	flash[:warning] = "You may only delete your own comments!"
	  end
    redirect_to post_path(@comment.post.subject.name, @comment.post.id)
	end

	private

		def comment_params
			params.require(:comment).permit(:body)
		end

end
