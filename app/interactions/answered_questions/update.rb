module AnsweredQuestions
  class Update < ApplicationInteraction
    attr_accessor :answered_question

    set_callback :execute, :before, :set_answered_question

    integer :answer_id
    integer :answered_question_id
    object :user

    def execute
      payload = { answer_id: answer_id, answered_at: DateTime.now }
      errors.merge!(answered_question.errors) unless answered_question.update(payload)
      answered_question
    end

    def set_answered_question
      @answered_question = user.answered_questions.find_by(id: answered_question_id)
      errors.add(:base, 'provide a valid answered_question_id') unless answered_question
    end
  end
end
