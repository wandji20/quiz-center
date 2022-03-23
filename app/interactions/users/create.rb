module Users
  class Create < ApplicationInteraction
    string :email
    string :username
    string :password
    string :password_confirmation

    def execute
      if new_user.save
        token = JsonWebToken.encode(user_id: new_user.id)

        user = ActiveModelSerializers::Adapter::Json.new(
          UserSerializer.new(new_user)
        ).serializable_hash

        quizzes = ActiveModelSerializers::SerializableResource.new(
          Quiz.all, scope: new_user, each_serilalizer: QuizSerializer
        ).as_json
        { Authorization: token, user: user, quizzes: quizzes }
      else
        errors.merge!(new_user.errors)
      end
    end

    def new_user
      payload = inputs.slice(:email, :username, :password, :password_confirmation)
      @new_user ||= User.new(payload)
    end
  end
end
