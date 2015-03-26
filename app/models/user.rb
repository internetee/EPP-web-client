class User
  attr_accessor :username, :password

  def initialize(username: nil, password: nil)
    self.username = username
    self.password = password
  end
end
