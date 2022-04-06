module Types
  module Query
    class ResultType < Types::BaseObject
      field :quiz_id, ID
      field :attempted, ID
      field :score, ID
    end
  end
end
