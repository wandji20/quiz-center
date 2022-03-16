class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def create
    token = AuthenticateUser.call(
      authentication_params[:email], authentication_params[:password]
    )
    @user = User.find_by(email: authentication_params[:email])
    user = ActiveModelSerializers::Adapter::Json.new(
      UserSerializer.new(@user)
    ).serializable_hash
    quizzes = ActiveModelSerializers::SerializableResource.new(
      Quiz.all, scope: @user, each_serilalizer: QuizSerializer
    ).as_json
    json_response({ Authorization: token, user: user, quizzes: quizzes })
  end

  def show
 
    user = ActiveModelSerializers::Adapter::Json.new(
      UserSerializer.new(current_user)
    ).serializable_hash
    quizzes = ActiveModelSerializers::SerializableResource.new(
      Quiz.all, scope: current_user, each_serilalizer: QuizSerializer
    ).as_json
    json_response({ user: user[:user], quizzes: quizzes })
  end

  private

  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end
end
