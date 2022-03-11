class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :description

  has_many :answers
end
