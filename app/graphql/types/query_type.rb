module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :quizzes, [Query::QuizType]
    field :user, Query::UserType do
      argument :id, ID, required: true
    end
    field :question, Query::QuestionType do
      argument :id, ID, required: true
    end

    field :answered_question, Query::AnsweredQuestionType do
      argument :id, ID, required: true
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

    def answered_question(id:)
      AnsweredQuestion.find_by(id: id)
    end

    def self.authorized?(object, context)
      current_user = context[:current_user]
      super && current_user&.present?
    end

    def self.authorized?(object, context)
      current_user = context[:current_user]
      super && current_user&.present?
    end
  end
end
