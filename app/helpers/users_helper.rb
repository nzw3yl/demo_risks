module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
     gravatar_image_tag(user.email.downcase,  :alt      => user.name,
                                              :class    => 'gravatar',
                                              :gravatar => options)
  end

  def elevated_priv?
    current_user.admin? || current_user.manager?
  end
end
