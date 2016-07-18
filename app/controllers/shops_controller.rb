class ShopsController < ApplicationController

	def index
		@inventory = Shop.all
	end

end
