class AuthenticationController < ApplicationController
  def create
    token = AuthenticateUser.call(
      authentication_params[:email], authentication_params[:password]
    )
    user = ActiveModelSerializers::Adapter::Json.new(
      UserSerializer.new(User.find_by(email: authentication_params[:email]))
    )
    json_response({ Authorization: token, user: user })
  end

  private
  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end

end
