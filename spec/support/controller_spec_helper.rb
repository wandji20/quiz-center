module ControllerSpecHelper
  def generate_token(id)
    JsonWebToken.encode(user_id: id)
  end

  def generate_expired_token(id)
    JsonWebToken.encode({ user_id: id }, 25.hours.ago)
  end

  def valid_headers(id)
    {
      Authorization: generate_token(id),
      'Content-Type': 'application/json'
    }
  end

  def invalid_headers
    {
      Authorization: nil,
      'Content-Type': 'applicaton/json'
    }
  end
end
