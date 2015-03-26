module CurrentUserHelper
  def current_user
    return User.new if !session[:tag] || !session[:password]

    @depp_current_user ||= Depp::User.new(
      tag: session[:tag],
      password: session[:password],
      pki: session[:pki]
    )
  end
end
