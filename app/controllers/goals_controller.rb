class GoalsController < ApplicationController
  load_resource :user
  load_and_authorize_resource
  def index
  end

  def new

  end

  def create
    if @goal.save
      @user.goals << @goal
      flash[:message] = "Goal created"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def goal_params
    params.require(:goal).permit(:name, :description, :community_id)
  end
end
