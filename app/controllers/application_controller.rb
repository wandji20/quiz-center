class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  before_action :authenticate_request

  attr_accessor :current_user

  private

  def authenticate_request
    # rubocop:disable Naming/MemoizedInstanceVariableName
    @current_user ||= AuthorizeApiRequest.call(request.headers)[:user]
    # rubocop:enable Naming/MemoizedInstanceVariableName
  end
end
