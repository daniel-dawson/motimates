class Connection < ApplicationRecord
  belongs_to :user
  belongs_to :motimate, class_name: "User", foreign_key: "motimate_id"

  enum status: {
    pending: "pending",
    requested: "requested",
    accepted: "accepted"
  }

  validates :user_id, presence: true
  validates :motimate_id, presence: true

  # Check if connection exists(whether pending or not)
  def self.connection?(user, motimate)
    !find_by(user_id: user.id, motimate_id: motimate.id).nil?
  end

  # Request a connection from user to (potential) motimate
  def self.request(user, motimate)
    unless user == motimate or Connection.connection?(user, motimate)
      transaction do # Insures integrity of database
        create(user_id: user.id, motimate_id: motimate.id, status: 'pending')
        create(user_id: motimate.id, motimate_id: user.id, status: 'requested')
      end
    end
  end

  # Accept a connection request
  def self.accept(user, motimate)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, motimate, accepted_at)
      accept_one_side(motimate, user, accepted_at)
    end
  end

  # Delete a connection or cancel a pending request
  def self.breakup(user, motimate)
    transaction do
      destroy(find_by(user_id: user.id, motimate_id: motimate.id))
      destroy(find_by(motimate_id: motimate.id, user_id: user.id))
    end
  end

  private

  # Update the db with one side of an accepted connection request.
  def self.accept_one_side(user, motimate, accepted_at)
    request = find_by(user_id: user.id, motimate_id: motimate.id)
    request.accepted!
    request.accepted_at = accepted_at
    request.save
  end
  # belongs_to :user #, inverse_of: :connections
  # belongs_to :connected_user, class_name: 'User' #, inverse_of: :connections
  #
  # after_create :create_inverse, unless: :has_inverse?
  # after_destroy :destroy_inverse, if: :has_inverse?
  #
  # enum status: {
  #
  # }
  #
  # def create_inverse
  #   self.class.create(inverse_connection_options)
  # end
  #
  # def destroy_inverse
  #   inverse.destroy
  # end
  #
  # def has_inverse?
  #   self.class.exists?(inverse_connection_options)
  # end
  #
  # def inverse
  #   self.class.where(inverse_connection_options)
  # end
  #
  # def accept_connection_request
  #   self.accept_inverse
  #   self.update(pending: false)
  # end
  #
  # def accept_inverse
  #   self.inverse.update(pending: false)
  # end
  #
  # private
  #
  # def inverse_connection_options
  #   { connected_user_id: user_id, user_id: connected_user_id }
  # end
end
