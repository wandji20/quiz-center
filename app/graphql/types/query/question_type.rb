module Types
  module Query
    class QuestionType < Types::BaseObject
      field :id, ID, null: false,
                     description: 'unique id of question'
      field :description, String, null: false,
                                  description: 'question description'
      field :points, Integer, null: false,
                              description: 'question difficulty level and duration'
      field :answers, [AnswerType], null: false,
                                    description: 'question answers'

      def answers
        object.answers
      end
    end
  end
end
