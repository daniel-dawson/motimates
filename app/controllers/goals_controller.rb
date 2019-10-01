class GoalsController < ApplicationController
  load_and_authorize_resource through: :current_user, shallow: true
  def index
  end
end
