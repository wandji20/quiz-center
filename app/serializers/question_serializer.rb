class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :points, :description, :answers

  def answers
    object.answers.shuffle
  end
end
