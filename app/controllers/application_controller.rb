class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to user_path(current_user), alert: exception.message if user_signed_in?
    redirect_to root_path, alert: exception.message if !user_signed_in?
  end

  def render(options = {})
    options[:json] = serializer.new(options[:json]) if serializer
    super(options)
  end

  def serializer
  end
end
