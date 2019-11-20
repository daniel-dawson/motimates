class MotimatesController < ApplicationController
  def index

  end

  def motimates_for_user
    user = User.find_by_id(params[:id])
    user_motimates = user.motimates
    render json: MotimateSerializer.new(user_motimates, {
      is_collection: true
    })
  end
end