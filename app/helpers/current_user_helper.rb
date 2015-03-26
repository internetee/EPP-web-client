module CurrentUserHelper
  def current_user
    return if !session[:tag] || !session[:password]

    # @depp_current_user ||= Depp::User.new(
      # tag: session[:tag],
      # password: session[:password],
      # pki: session[:pki]
    # )
    @depp_current_user ||= User.new
  end
end
