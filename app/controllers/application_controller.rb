class ApplicationController < ActionController::Base
  include CurrentUserHelper
  helper ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  helper_method :current_user

  def authenticate_user
    redirect_to main_app.login_url and return unless depp_current_user && session[:last_seen]

    if (session[:last_seen].to_i + ENV['session_timeout'].to_i) < Time.now.to_i
      session_timeout
    else
      session[:last_seen] = Time.now.to_i
    end
  end

  def session_timeout
    reset_session
    flash[:alert] = t('your_session_has_timed_out')
    redirect_to main_app.login_url and return
  end

  def depp_current_user
    @depp_current_user ||= Depp::User.new(
      tag: current_user.username,
      password: current_user.password
    )
  end

end
