class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  api :POST, '/sign_up', 'Create a new user account'
  param :user, Hash, 'User', required: true do
    param :first_name, String, 'First name', required: true
    param :last_name, String, 'Last name', required: true
    param :email, String, 'email', required: true
    param :password, String, 'Password', required: true
    param :password_confirmation, String, 'Password confirmation', required: true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)

      user = ActiveModelSerializers::Adapter::Json.new(
        UserSerializer.new(@user)
      ).serializable_hash

      quizzes = ActiveModelSerializers::SerializableResource.new(
        Quiz.all, scope: @user, each_serilalizer: QuizSerializer
      ).as_json

      json_response({ Authorization: token, user: user, quizzes: quizzes }, :created)
    else
      json_response({ errors: @user.errors }, :unprocessable_entity)
    end
  end

  api :GET, '/result', 'User Result'
  header :Authorization, 'Authentication token', required: true
  def show
    result = current_user.result
    render json: { resul: result }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation
    )
  end
end
