class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
  end

  def delete_avatar
    @user.avatar.purge
    flash[:message] = "Uploaded picture deleted"
    redirect_to edit_user_registration_path
  end

  private

end
