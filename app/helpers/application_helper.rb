module ApplicationHelper
	def full_title(page = '')
		base = "Vezzelution"
		full_title = page.empty? ? base : "#{page} | #{base}"
	end

	def vezley_logo
		if User.find_by(name: "vezley")
			User.find_by(name: "Vezley").logo || "https://static-cdn.jtvnw.net/jtv_user_pictures/vezley-profile_image-91f07216710aec58-300x300.jpeg"
		else
			"https://static-cdn.jtvnw.net/jtv_user_pictures/vezley-profile_image-91f07216710aec58-300x300.jpeg"
		end
	end
end
