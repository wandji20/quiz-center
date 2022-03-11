module AnsweredQuestions
  class Update

    attr_reader :id, :answer_id
    attr_accessor :errors, :answer, :answered_question, :result

    def initialize(id, answer_id)
      @answer_id = answer_id
      @id = id
      @errors = {}
    end
    
    def self.call(attributes = {})
      outcome = self.new(attributes[:id], attributes[:answer_id])
      outcome.update_answered_question
      outcome
    end

    def valid?
      errors.none?
    end

    
    def update_answered_question
      set_answered_question
      set_answer if answered_question
      if valid?
        payload = {
          answered_at: DateTime.now,
          answer_id: answer.id
        }
        if answered_question.update(payload)
          @result = answered_question
        else
          errors.merge!(answered_question.errors)
        end
      end
      self
    end
    
    private
    def set_answer
      if answered_question
        @answer = answered_question.question.answers.find_by id: answer_id
        errors.merge!(base: 'valid question answer must be present') unless @answer
      end
    end

    def set_answered_question
      @answered_question = AnsweredQuestion.find_by id: id

      errors.merge!(
        base: 'answered question not found'
      ) unless answered_question
    end

  end
end