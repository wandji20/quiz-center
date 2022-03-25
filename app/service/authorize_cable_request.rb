class AuthorizeCableRequest
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def self.call(token)
    new(token).user
  end

  # assign user from decoded authorization token
  def user
    @user ||= User.find_by(id: decoded_auth_token[:user_id])
  end

  # decode authorization token
  def decoded_auth_token
    JsonWebToken.decode(token)
  end
end
