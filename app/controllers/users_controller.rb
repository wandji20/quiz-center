class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

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
      json_response({ errors: @user.errors.full_messages }, :unprocessable_entity)
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
