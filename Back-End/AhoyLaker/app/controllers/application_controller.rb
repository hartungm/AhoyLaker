class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   
  helper_method :current_user_session, :current_user

  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_admin
    @current_admin ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_admin.is_admin
      redirect_to '/organizations/' + @current_admin.organization_id.to_s + '/'
      #redirect_to '/'
    end
  end

  def require_user
    redirect_to '/login' unless current_user
  end

end
