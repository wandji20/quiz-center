module Authentication
  class Create < ApplicationInteraction
    string :email
    string :password

    def execute
      token = AuthenticateUser.call(email, password)

      @user = User.find_by(email: email)

      user = ActiveModelSerializers::Adapter::Json.new(
        UserSerializer.new(@user)
      ).serializable_hash

      quizzes = ActiveModelSerializers::SerializableResource.new(
        Quiz.all, scope: @user, each_serilalizer: QuizSerializer
      ).as_json
      { Authorization: token, user: user[:user], quizzes: quizzes }
    end
  end
end
