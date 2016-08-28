module UsersHelper

	# Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    if !user.email.nil?
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    else
      gravatar_id = Digest::MD5::hexdigest("noemail@example.com")
    end
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def logo_for(user, options = {size: 80})
  	size = options[:size]
  	if user.logo
  		image_tag(user.logo, alt: user.name, size: "#{size}x#{size}",
  																						class: "user-logo")
  	else
  		gravatar_for(user, size: options[:size])
  	end
  end
end
