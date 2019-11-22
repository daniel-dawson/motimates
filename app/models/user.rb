require 'uri'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_one :preference

  has_many :connections
  has_many :motimates,
            -> { where(connections: { status: "accepted" }).order(:name) },
            through: :connections
  has_many :motimate_requests,
            -> { where(connections: { status: "requested" }).order(:created_at) },
            through: :connections,
            source: :motimate
  has_many :motimates_pending,
            -> { where(connections: { status: "pending" }).order(:created_at) },
            through: :connections,
            source: :motimate

  has_many :goals
  has_many :communities, through: :goals

  has_one_attached :avatar

  # TODO: write scope for distinct communities
  # TODO: write scope for top 3 most involved communities

  def self.from_omniauth(access_token)
    puts "INFO: #{access_token.info}"
    data = access_token.info
    user = User.where(email: data["email"]).first

    img_url = data['image']

    img_filename = File.basename(URI.parse(img_url).path)
    img_file = URI.open(img_url)

    # Create user if they don't exist
    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
        user.avatar.attach(io: img_file, filename: img_filename)
    end
    user
  end

end
