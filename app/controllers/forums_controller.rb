class ForumsController < ApplicationController

	def index
	end

	def show
		@subject = ((params[:subject] == "all") ? Subject.all : Subject.find_by_name(params[:subject]))
		@post = ((params[:subject] == "all") ? Post.all : Post.where(subject_id: @subject.id).find_each)
	end

	def new
		@subject = params[:subject]
		@post = Post.new
	end

	def create
		@post = Post.new post_params
	end

	private

		def post_params
			params.require(:post).permit(:title, :body, :user_id, :subject_id)
		end

end
