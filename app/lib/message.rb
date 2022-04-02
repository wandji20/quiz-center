# Default messages used by exception handlers
class Message
  class << self
    def invalid_credentials
      'Invalid credentials'
    end

    def invalid_token
      'Invalid token'
    end

    def missing_token
      'Missing/Invalid token'
    end

    def unauthorized
      'Unauthorized request'
    end

    def missing_param
      'is missing or invalid'
    end
  end
end
