module Mutations
  module AnsweredQuestion
    class UpdateAnsweredQuestion < BaseMutation
      field :answered_question, ::Types::Query::AnsweredQuestionType, null: false
      field :errors, [String]

      argument :answer_id, ID, required: true
      argument :answered_question_id, ID, required: true

      def resolve(answer_id:, answered_question_id:)
        payload = {
          answer_id: answer_id,
          answered_question_id: answered_question_id,
          user: context[:current_user]
        }
        outcome = ::AnsweredQuestions::Update.run(payload)
  
        { answered_question: outcome.result }
      end
    end
  end
end
