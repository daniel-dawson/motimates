class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :preference

  has_many :connections
  has_many :motimates,
            -> { where(connections: { status: "accepted" }).order(:name) },
            through: :connections
  has_many :requested_motimates,
            -> { where(connections: { status: "requested" }).order(:created_at) },
            through: :connections,
            source: :motimate
  has_many :pending_motimates,
            -> { where(connections: { status: "pending" }).order(:created_at) },
            through: :connections,
            source: :motimate

  has_many :memberships
  has_many :communities, through: :memberships
  has_many :goals, through: :communities

end
