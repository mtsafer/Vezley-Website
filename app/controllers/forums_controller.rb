class ForumsController < ApplicationController

	def index
	end

	def show
		if params[:subject] == "all"
			@subject = Subject.all
			@forums = Post.order(sticky: :desc, updated_at: :desc).all
		else
			@subject = Subject.find_by_name(params[:subject])
			@forums = Post.where(subject_id: @subject.id).order(sticky: :desc,
												updated_at: :desc).paginate(page: params[:page],
																									  per_page: 10)
		end
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
