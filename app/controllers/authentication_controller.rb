class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  api :POST, '/login', 'Initiate an answerd question'
  param :authentication, Hash, 'Authentication', required: true do
    param :email, String, 'email', required: true
    param :password, String, 'Password', required: true
  end

  def create
    outcome = Authentication::Create.run(authentication_params)
    json_response(outcome.result)
  end

  private

  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end
end
