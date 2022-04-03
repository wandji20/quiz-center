module AnsweredQuestions
  class Create < ApplicationInteraction
    attr_accessor :existing_answered_question

    integer :quiz_id
    integer :question_id
    object :user

    set_callback :execute, :before, :verify_existence?

    # creates an answered_question, broadcast answered_question if
    # successfully created or merges errors to interaction object
    def execute
      return existing_answered_question if verify_existence?

      payload = inputs.slice(:question_id, :quiz_id)
      @answered_question = user.answered_questions.build(payload)
      @answered_question.save

      errors.merge!(@answered_question.errors) unless @answered_question.valid?
      @answered_question
    end

    def verify_existence?
      @existing_answered_question = user.answered_questions.where(
        'quiz_id = ? AND question_id = ?', quiz_id, question_id
      ).take
      @existing_answered_question.present?
    end
  end
end
