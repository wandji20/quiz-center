# handle exceptions raised during runtime
module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end

  class InvalidToken < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorised_request!
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessed_request!
  end

  def unprocessed_request!(exception)
    json_response({ alert: exception.message }, :unprocessable_entity)
  end

  def unauthorised_request!(exception)
    json_response({ alert: exception.message }, :unauthorized)
  end
end
