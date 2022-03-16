class AuthorizeCableRequest
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def self.call(token)
    self.new(token).call
  end

  def call
    @user ||= User.find_by(id: decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    JsonWebToken.decode(token)
  end
end