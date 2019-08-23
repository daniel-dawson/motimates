class Community < ApplicationRecord
  has_many :goals
  has_many :memberships
  has_many :users, through: :memberships
end
