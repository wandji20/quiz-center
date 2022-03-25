# handle exceptions raised during runtime
module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError
  end

  class MissingToken < StandardError
  end

  class InvalidToken < StandardError; end

  included do
    rescue_from ActionController::ParameterMissing, with: :require_param!
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorised_request!
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessed_request!
    rescue_from ExceptionHandler::MissingToken, with: :unprocessed_request!
  end

  def unprocessed_request!(exception)
    json_response({ alert: exception.message }, :unprocessable_entity)
  end

  def unauthorised_request!(exception)
    json_response({ alert: exception.message }, :unauthorized)
  end

  def require_param!(error)
    message_prefix = error.instance_of?(String) ? error : error.param.to_s.humanize
    message = message_prefix + " #{Message.missing_param}"
    json_response({ alert: message }, 400)
  end
end
