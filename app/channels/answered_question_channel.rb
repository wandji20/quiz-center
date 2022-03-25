class AnsweredQuestionChannel < ApplicationCable::Channel
  # Open unique stream for answered question channel with the email of authenticated user
  def subscribed
    stream_from "answered_question_#{params[:email]}"
  end

  # Updates answered question answer attribute
  def receive(data)
    answer_id = data['answer_id']&.to_i
    answered_question_id = data['answered_question_id']&.to_i
    answered_question = current_user.answered_questions.find_by(
      id: answered_question_id
    )
    answered_question.update(answer_id: answer_id, answered_at: DateTime.now)
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
end
