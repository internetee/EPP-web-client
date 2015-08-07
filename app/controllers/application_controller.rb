class ApplicationController < ActionController::Base
  include CurrentUserHelper
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  helper_method :current_user
  helper_method :depp_current_user

  rescue_from(Errno::ECONNRESET, Errno::ECONNREFUSED) do |_exception|
    redirect_to main_app.login_url, alert: t(:no_connection_to_registry)
  end

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
    return nil unless current_user
    @depp_current_user ||= Depp::User.new(
      tag: current_user.username,
      password: current_user.password
    )
  end

  def response_ok?
    @data.css('result').each do |x|
      success_codes = %(1000, 1001, 1300, 1301)
      return false unless success_codes.include?(x['code'])
    end
    true
  end
end
