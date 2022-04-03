# frozen_string_literal: true

module Types
  class AnsweredQuestionType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :question_id, Integer, null: false
    field :answer_id, Integer
    field :created_at, GraphQL::Types::BigInt, null: false

    field :quiz_id, Integer
    field :updatable, Boolean, null: false

    # is the current time within the period for which an answer will be valid
    def updatable
      object.updatable?
    end
  
    # convert answered question created_at attribute to milliseconds
    def created_at
      object.created_at.to_i * 1000
    end
  end
end
