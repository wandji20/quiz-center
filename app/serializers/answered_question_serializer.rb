class AnsweredQuestionSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updatable

  def updatable
    object.updatable?
  end

  # convert answered question created_at attribute to milliseconds
  def created_at
    object.created_at.to_i * 1000
  end
end
