class InfoBlocksController < ApplicationController

	def edit
		@infoblock = InfoBlock.find_by_id params[:id]
	end

	def update
		@infoblock = InfoBlock.find_by_id params[:id]
		@infoblock.update whitelist
		redirect_to root_url
	end

	private

	def whitelist
		params.require(:info_block).permit(:title, :body)
	end

end
