class AnsweredQuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answered_question_#{params[:id]}"
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
end
