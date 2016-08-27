class Viewing < ApplicationRecord

	def view_now
		update_attribute(:viewed_at, Time.zone.now)
	end

end
