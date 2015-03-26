module CurrentUserHelper
  def current_user
    return User.new if !session[:tag] || !session[:password]

    @current_user ||= User.new(
      username: session[:tag],
      password: session[:password]
    )
  end
end
