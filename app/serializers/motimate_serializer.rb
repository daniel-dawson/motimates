class MotimateSerializer
  include FastJsonapi::ObjectSerializer
  include Rails.application.routes.url_helpers
  extend AvatarHelper
  set_key_transform :camel_lower

  attributes :name, :age, :gender, :location
  attribute :avatar_url do |moti|
    Rails.application.routes.url_helpers.rails_blob_url(moti.avatar) if moti.avatar.attached?
  end
  attribute :default_avatar_url do |moti|
    gravatar_url_for moti
  end
  link :profile_url do |moti|
    "http://localhost:3000/users/#{moti.id}"
  end
end
