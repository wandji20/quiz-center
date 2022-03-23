module Authentication
  class Show < ApplicationInteraction
    object :current_user, class: 'User'

    def execute
      user = ActiveModelSerializers::Adapter::Json.new(
        UserSerializer.new(current_user)
      ).serializable_hash
  
      quizzes = ActiveModelSerializers::SerializableResource.new(
        Quiz.all, scope: current_user, each_serilalizer: QuizSerializer
      ).as_json
  
      { user: user[:user], quizzes: quizzes }
    end
  end
end