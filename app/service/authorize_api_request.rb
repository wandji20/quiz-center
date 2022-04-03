class AuthorizeApiRequest
  attr_accessor :headers

  def initialize(headers = {})
    @headers = headers
  end

  def self.call(headers = {})
    new(headers).user
  end

  # assign user from decoded authorization token or nil if no header or invalid token
  def user
    return unless header_is_present?
    return unless decoded_auth_token

    @user ||= User.find_by_id(decoded_auth_token[:user_id])
  end

  # check wether header header is present an not blank
  def header_is_present?
    !!headers[:Authorization]&.blank?
  end

  # grab authorization token from header or raise error
  def http_header_token
    headers[:Authorization].split.last
  end

  # decode authorization token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_header_token)
  end
end
