class BroadcastJob
  include Sidekiq::Job

  def perform(answered_question_id, user_id, status)
    current_user = User.find_by(id: user_id)
    answered_question = AnsweredQuestion.find(answered_question_id)
    send_broadcast(answered_question, current_user.email, status)
  end

  private

  def send_broadcast(answered_question, email, status)
    answered_question = ActiveModelSerializers::Adapter::Json.new(
      AnsweredQuestionSerializer.new(answered_question)
    )
    ActionCable.server.broadcast(
      "answered_question_#{email}",
      { answered_question: answered_question, status: status }
    )
  end
end
