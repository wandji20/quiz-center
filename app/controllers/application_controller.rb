# rubocop:disable Naming/MemoizedInstanceVariableName
class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_accessor :current_user

  private

  # authorize jwt and assign a current user
  def authenticate_request
    @current_user ||= AuthorizeApiRequest.call(request.headers)
  end
end
# rubocop:enable Naming/MemoizedInstanceVariableName
