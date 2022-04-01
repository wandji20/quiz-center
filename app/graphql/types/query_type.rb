module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :quizzes, [Types::QuizType], null: false
    field :users, [Types::UserType], null: false
    field :user, Types::UserType do
      argument :id, ID, required: true
    end
    field :question, Types::QuestionType do
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def quizzes
      Quiz.all
    end

    def user(id:)
      User.find_by(id: id)
    end

    def question(id:)
      Question.find_by(id: id)
    end
  end
end
