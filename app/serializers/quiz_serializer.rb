class QuizSerializer < ActiveModel::Serializer
  attributes :id, :title
  attribute :question_ids, if: -> { scope }

  def question_ids
    unanswered_question_ids = current_user.unanswered_questions.ids
    object.questions.where(id: unanswered_question_ids).ids
  end

  def current_user
    scope
  end
end
