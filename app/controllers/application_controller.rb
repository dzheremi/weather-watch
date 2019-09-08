class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authorised_user
    if session[:user]
      @current_user = User.find(session[:user])
      true
    else
      @current_user = nil
      false
    end
  end

  def set_time_zone(&block)
    if @current_user
      timezone = @current_user.timezone.location
    else
      timezone = 'Melbourne'
    end
    Time.use_zone(timezone, &block)
  end

end
