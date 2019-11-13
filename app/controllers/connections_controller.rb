class ConnectionsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource :user, except: [:show]
  before_action :set_motimate, except: [:show]
  # load_resource :motimate
  # load_resource :motimate, through: :user, only: [:create, :accept]

  def index
  end

  def show
    c = Connection.find_by_id(params[:id])
    respond_to do |format|
      format.json { render json: c }
    end
  end

  def create
    params[:note].strip.empty? ?
      Connection.request(@user, @motimate) :
      Connection.request(@user, @motimate, params[:note])
    if Connection.connected?(@user, @motimate)
      flash[:success] = "Motimate request sent"
      connection = Connection.find_by(user_id: @user.id, motimate_id: @motimate.id)
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.json { render json: connection }
      end
    else
      flash[:notice] = "Users weren't connected"
      redirect_to user_path(@user)
    end
  end

  def accept
    if @user.motimate_requests.include?(@motimate)
      Connection.accept(@user, @motimate)
      flash[:notice] = "Now motimates with #{@motimate.name.humanize}!"
    else
      flash[:notice] = "No friendship request from #{@motimate.name.humanize}."
    end
    connection = Connection.find_by(user_id: @user.id, motimate_id: @motimate.id)
    respond_to do |format|
      format.html
      format.json { render json: connection }
    end
  end

  private

  def serializer
    ConnectionSerializer
  end

  def set_motimate
    @motimate = User.find_by_id(params[:motimate_id])
  end
end
