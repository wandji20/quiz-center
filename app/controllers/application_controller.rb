class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  before_action :authenticate_request

  private
  def authenticate_request
    @current_user ||= AuthenticateUser.call(requests['headers'])
  end
end
