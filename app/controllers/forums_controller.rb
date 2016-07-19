class ForumsController < ApplicationController

	def index
	end

	def show
		@subject = ((params[:subject] == "all") ? Subject.all : Subject.find_by_name(params[:subject]))
	end

end
