module AnsweredQuestions
  class Create < ApplicationInteraction
    integer :quiz_id
    integer :question_id
    integer :answer_id, default: nil
    object :user

    def execute
      payload = inputs.slice(:question_id, :answer_id, :quiz_id)
      @answered_question = user.answered_questions.build(payload)
      if @answered_question.save
        BroadcastJob.perform_async(@answered_question.id, user.id, true)
      else
        errors.merge!(@answered_question.errors)
      end
      @answered_question
    end
  end
end
