module Mutations
  module AnsweredQuestion
    class CreateAnsweredQuestion < BaseMutation
      field :answered_question, ::Types::Query::AnsweredQuestionType, null: false
      field :question, ::Types::Query::QuestionType, null: false
      field :errors, [String]

      argument :quiz_id, ID, required: true
      argument :question_id, ID, required: true

      def resolve(quiz_id:, question_id:)
        payload = {
          quiz_id: quiz_id,
          question_id: question_id,
          user: context[:current_user]
        }
        new_answered_question payload
      end

      def new_answered_question(payload)
        outcome = ::AnsweredQuestions::Create.run(payload)
        { 
          answered_question: outcome.result, 
          question: Question.find_by(id: payload[:question_id])
        }
      end
    end
  end
end
