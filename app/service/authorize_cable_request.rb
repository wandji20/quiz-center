class AuthorizeCableRequest
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def self.call(token)
    new(token).user
  end

  def user
    @user ||= User.find_by(id: decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    JsonWebToken.decode(token)
  end
end
