class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to user_path(current_user), alert: exception.message if user_signed_in?
    redirect_to root_path, alert: exception.message if !user_signed_in?
  end
end
