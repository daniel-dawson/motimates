require "erb"
require "digest"

module AvatarHelper
  BASE_GRAVATAR_URL = "https://www.gravatar.com/avatar"
  DEFAULT_GRAVATAR_SIZE = 500

  BASE_DEFAULT_AVATAR_URL = "https://ui-avatars.com/api"
  DEFAULT_AVATAR_COLOR = "FF59B7"
  DEFAULT_AVATAR_LENGTH = 1
  DEFAULT_AVATAR_SIZE = 500
  DEFAULT_AVATAR_BACKGROUND = "F0E9E9"
  DEFAULT_AVATAR_FONT_SIZE = 0.6
  DEFAULT_AVATAR_ROUNDED = false
  DEFAULT_AVATAR_UPPERCASE = true
  DEFAULT_AVATAR_BOLD = true

  # ! Order is significant
  DEFAULT_AVATAR_OPTIONS = {
    "size": DEFAULT_AVATAR_SIZE,
    "background": DEFAULT_AVATAR_BACKGROUND,
    "color": DEFAULT_AVATAR_COLOR,
    "length": DEFAULT_AVATAR_LENGTH,
    "font_size": DEFAULT_AVATAR_FONT_SIZE,
    "rounded": DEFAULT_AVATAR_ROUNDED,
    "uppercase": DEFAULT_AVATAR_UPPERCASE,
    "bold": DEFAULT_AVATAR_BOLD,
  }

  def default_avatar_path_for(user)
    build_path(user, DEFAULT_AVATAR_OPTIONS)
  end

  # @param user User object
  # @param query_options Hash of query params
  # @return path String representing path for default avatar
  def build_path(user, query_options)
    path = "/#{user.name}"
    query_options.each do |k, v|
      path.concat("/#{v}") # * Query params formatted as sub-directories due to limitation of gravatar
    end
    path
  end
  
  # @param user User object
  # @return String Represents the url to get default avatar from
  def default_avatar_url(user)
    BASE_DEFAULT_AVATAR_URL + default_avatar_path_for(user)
  end

  def encoded_default_avatar_url_for(user)
    ERB::Util.url_encode(default_avatar_url(user))
  end

  def gravatar_url_for(user)
    "#{BASE_GRAVATAR_URL}/#{email_hash(user.email)}#{gravatar_query_params_for(user)}"
  end

  def gravatar_query_params_for(user)
    "?s=#{DEFAULT_GRAVATAR_SIZE}&d=#{encoded_default_avatar_url_for(user)}"
  end

  def email_hash(email)
    # * Gravatar api requires email be stripped of whitespace and forced to lowercase
    Digest::MD5.hexdigest(email.strip.downcase)
  end
end
