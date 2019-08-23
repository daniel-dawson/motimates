class Connection < ApplicationRecord
  belongs_to :user #, inverse_of: :connections
  belongs_to :connected_user, class_name: 'User' #, inverse_of: :connections

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverse, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_connection_options)
  end

  def destroy_inverse
    inverse.destroy
  end

  def has_inverse?
    self.class.exists?(inverse_connection_options)
  end

  def inverse
    self.class.where(inverse_connection_options)
  end

  def accept_connection_request
    self.update(pending: false)
  end

  def accept_inverse
    self.inverse.update(pending: false)
  end

  private

  def inverse_connection_options
    { connected_user_id: user_id, user_id: connected_user_id }
  end
end
