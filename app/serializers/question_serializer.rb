class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :points, :description

  has_many :answers
end
