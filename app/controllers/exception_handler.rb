module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError
  end

  class MissingToken < StandardError
  end

  class InvalidToken < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorised_request!
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessed_request!
    rescue_from ExceptionHandler::MissingToken, with: :unprocessed_request!
  end

  def unprocessed_request!(_exception)
    json_response({ alert: exeption.message }, status: :unprocessable_entity)
  end

  def unauthorised_request!(_exception)
    json_response({ alert: exeption.message }, status: :unauthorised)
  end
end
