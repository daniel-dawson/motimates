class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :preference
  has_many :connections
  has_many :memberships
  has_many :communities, through: :memberships
  has_many :goals, through: :communities
  has_many :connected_users, through: :connections
end
