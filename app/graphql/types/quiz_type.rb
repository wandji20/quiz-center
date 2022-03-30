module Types
  class QuizType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :question_ids, [ID], null: false

    def question_ids
      []
    end
  end
end
