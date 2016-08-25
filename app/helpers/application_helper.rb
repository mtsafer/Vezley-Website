module ApplicationHelper
	def full_title(page = '')
		base = "Vezzelution"
		full_title = page.empty? ? base : "#{page} | #{base}"
	end
end
