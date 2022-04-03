module Mutations
  module Authentication
    class CreateAuthentication < BaseMutation

      field :token, String, null: false
      field :user, ::Types::Query::UserType, null: false
      field :quizzes, [::Types::Query::QuizType]
      field :errors, [String], null: false
  
      argument :email, String, required: true
      argument :password, String, required: true
  

      def resolve(email:, password:)
        token = AuthenticateUser.call(email, password)
        # outcome = ::Authentication::Create.run({ email: email, password: password })
        user = User.find_by(email: email)
        context[:current_user] = user
        { token: token, user: user, quizzes: Quiz.all }
      end
    end
  end
end
