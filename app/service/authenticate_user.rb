class AuthenticateUser
  
  def initialize(email, password)
    @email = email
    @password = password
  end

  def self.call(email, password)
    self.new(email, password).generate_user_token
  end
  
  def generate_user_token
    JsonWebToken.encode(user_id: user.id) if user
  end
  private
  attr_reader :email, :password
  
  def user
    @user ||= User.find_by(email: email)
    return @user if  @user && @user.authenticate(password)

    raise ExceptionHandler::AuthenticationError, Message.invalid_credentials
  end

end