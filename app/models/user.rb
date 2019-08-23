class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :preference

  has_many :connections
  has_many :connected_users, through: :connections, dependent: :destroy
  # has_many :inverse_connections, class_name: 'Connection', foreign_key: 'connected_user_id', inverse_of: :user
  # has_many :inverse_connected_users, through: :inverse_connections, source: :user, dependent: :destroy

  has_many :memberships
  has_many :communities, through: :memberships
  has_many :goals, through: :communities

end
