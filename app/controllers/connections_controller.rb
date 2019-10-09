class ConnectionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  before_action :set_motimate
  # load_resource :motimate, through: :user, only: [:create, :accept]

  def index
  end

  def create
    Connection.request(@user, @motimate)
    flash[:success] = "Motimate request sent"
    redirect_to user_path(@user)
  end


  def accept
    if @user.motimate_requests.include?(@motimate)
      Connection.accept(@user, @motimate)
      flash[:notice] = "Now motimates with #{@motimate.name.humanize}!"
    else
      flash[:notice] = "No friendship request from #{@motimate.name.humanize}."
    end
    redirect_to user_path(@user)
  end

  private

  def set_motimate
    @motimate = User.find_by_id(params[:motimate_id])
  end
end
