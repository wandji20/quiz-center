class AnsweredQuestionSerializer < ActiveModel::Serializer
  attributes :id, :created_at
  belongs_to :question

  def created_at
    object.created_at.to_i * 1000
  end
end
