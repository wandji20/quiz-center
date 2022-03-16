class AnsweredQuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answered_question_#{params[:email]}"
  end

  def receive(data)
    p 'kkkkkkkkkkkkkk'
    p data
    answered_question = current_user.answered_questions.build(data['answered_question'])
    p answered_question
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
end
