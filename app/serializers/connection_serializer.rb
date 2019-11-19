require_relative "./concerns/avatar_helper.rb"

class ConnectionSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :note, :accepted_at
  belongs_to :user
  belongs_to :motimate
end
