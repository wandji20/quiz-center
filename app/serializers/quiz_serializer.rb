class QuizSerializer < ActiveModel::Serializer
  attributes :id, :title
  attribute :question_ids

  def question_ids
    if current_user
      unanswered_question_ids = current_user.unanswered_questions.ids
      Question.joins(:quiz).where(quiz: { id: object.id }).where(id: unanswered_question_ids).ids
    else
      []
    end
  end

  def current_user
    scope
  end
end
