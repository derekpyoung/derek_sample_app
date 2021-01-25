module UsersHelper

  # returns teh gravatar for givin users
  def gravatar_for(user, options = {size: 1})
    size          = options[:size]
    gravatar_id   = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url  = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#
    {size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")

  end
end
