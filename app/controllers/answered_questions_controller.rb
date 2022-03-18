class AnsweredQuestionsController < ApplicationController
  include Broadcast
  before_action :verify_answered_question_existence, only: :create
  
  def create
    @answered_question = current_user.answered_questions.build(answered_question_params)
    if @answered_question.save
      send_broadcast(@answered_question)
      json_response(
        { answered_question_id: @answered_question.id }, :created
      )
    else
      json_response(
        { errors: @answered_question.errors.full_messages },
        :unprocessable_entity
      )
    end
  end

  def update
    outcome = AnsweredQuestions::Update.call(
      answered_question_params.slice(:answer_id, {}).merge!(id: params[:id])
    )
    if outcome.valid?
      ActionCable.server.broadcast(
        "answered_question_#{current_user.email}", { notice: 'saved' }
      )
      json_response({ notice: 'saved' })
    else
      json_response({ errors: outcome.errors }, :unprocessable_entity)
    end
  end

  private

  def answered_question_params
    params.require(:answered_question).permit(:question_id, :answer_id, :quiz_id)
  end
end
