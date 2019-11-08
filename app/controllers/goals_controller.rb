class GoalsController < ApplicationController
  load_resource :user
  load_and_authorize_resource
  def index
  end

  def new
    @goal.community_id = params[:community_id] if params[:community_id].present?
  end

  def create
    if @goal.save
      @user.goals << @goal
      flash[:message] = "Goal created"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Something went wrong"
      render :new
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :description, :community_id)
  end
end
