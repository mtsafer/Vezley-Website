class TipJarsController < ApplicationController

	def index
		@infoblock = InfoBlock.find_by_name("donate")
	end

end
