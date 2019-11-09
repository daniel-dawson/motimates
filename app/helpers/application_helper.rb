module ApplicationHelper
  def flash_class_name(name)
    name == "alert" ? "ui error message" : "ui info message"
  end

  def avatar_image_tag(user, size, class_string)
    if user.avatar.attached?
      if user.avatar.variable?
        image_tag(user.avatar.variant(resize: "#{size}x#{size}!"), class: "#{class_string}")
      else
        image_tag(gravatar_image_url(user.email, size: size), height: size, width: size, class: "#{class_string}")
      end
    else
      image_tag(gravatar_image_url(user.email, size: size), height: size, width: size, class: "#{class_string}")
    end
  end
end
