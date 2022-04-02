module Types
  class QuizType < Types::BaseObject
    field :id, ID, null:false,
                   description: 'unique quiz id'
    field :title, String, null:false,
                          description: 'unique title for quiz'
    field :question_ids, [ID], null:false,
                               description: 'unique id of unanswered questions'

    def question_ids
      current_user = context[:current_user]
      unanswered_question_ids = current_user.unanswered_questions.ids
      Question.joins(:quiz).where(quiz: { id: object.id }).where(id: unanswered_question_ids).ids
    end
  end
end
