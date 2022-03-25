class AuthorizeApiRequest
  attr_accessor :headers

  def initialize(headers = {})
    @headers = headers
  end

  def self.call(headers = {})
    new(headers).user
  end

  # assign user from decoded authorization token or raise error
  def user
    @user ||= User.find(decoded_auth_token[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise ExceptionHandler::InvalidToken, Message.invalid_token
  end

  # grab authorization token from header or raise error
  def http_header_token
    return headers[:Authorization].split.last if headers[:Authorization]&.present?

    raise ExceptionHandler::MissingToken, Message.missing_token
  end

  # decode authorization token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_header_token)
  end
end
