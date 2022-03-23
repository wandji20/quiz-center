class AnsweredQuestionsController < ApplicationController
  include Verification
  before_action :verify_answered_question_existence, only: :create

  api :POST, '/answered_questions', 'Initiate an answerd question'
  header :Authorization, 'Authentication token', required: true
  param :answered_question, Hash, 'Answered Question', required: true do
    param :question_id, Integer, desc: 'id of the question', required: true
    param :quiz_id, Integer, desc: 'id of the question', required: true
    param :answer_id, Integer, desc: 'id of the question'
  end

  def create
    @answered_question = current_user.answered_questions.build(answered_question_params)
    if @answered_question.save
      BroadcastJob.perform_async(@answered_question.id, current_user.id, true)
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

  private

  def answered_question_params
    params.require(:answered_question).permit(:question_id, :answer_id, :quiz_id)
  end
end
