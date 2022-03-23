# rubocop:disable Naming/MemoizedInstanceVariableName
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  before_action :authenticate_request

  attr_accessor :current_user

  private

  def authenticate_request
    @current_user ||= AuthorizeApiRequest.call(request.headers)
  end
end
# rubocop:enable Naming/MemoizedInstanceVariableName
