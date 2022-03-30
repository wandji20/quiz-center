module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :points, Integer, null: false
    field :quiz_id, Integer, null: false
    field :answers, [Types::AnswerType], null: false

    def answers
      object.answers
    end
  end
end
