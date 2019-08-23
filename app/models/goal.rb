class Goal < ApplicationRecord
  belongs_to :community
  belongs_to :user, inverse_of: :goals
end
