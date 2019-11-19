class UserSerializer
  include FastJsonapi::ObjectSerializer
  extend AvatarHelper
  set_key_transform :camel_lower

  attributes :name, :age, :gender, :location
  attribute :avatar_url do |user|
    # variant = user.avatar.variant(resize: "250x250!") if user.avatar.attached?
    # return rails_blob_path(variant, disposition: "attachment") if variant
    Rails.application.routes.url_helpers.rails_blob_url(user.avatar) if user.avatar.attached?
  end
  attribute :default_avatar_url do |user|
    gravatar_url_for user
  end
end
