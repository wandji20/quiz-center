class AnsweredQuestionsController < ApplicationController
  def create
    @answered_question = current_user.answered_questions.build(answered_question_params)
    if @answered_question.save
      question = ActiveModelSerializers::Adapter::JSon.new(
        QuestionSerializer.new(@answerd_question.question)
      )
      ActionCable.server.broadcast(
        "answered_question_#{@answered_question.id}", question
      )
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
      json_response({ notice: 'saved' })
    else
      json_response({ errors: outcome.errors }, :unprocessable_entity)
    end
  end

  private

  def answered_question_params
    params.require(:answered_question).permit(:question_id, :answer_id)
  end
end
