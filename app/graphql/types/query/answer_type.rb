module Types
  module Query
    class AnswerType < Types::BaseObject
      field :id, ID, null: false
      field :value, String, null: false
    end
  end
end
