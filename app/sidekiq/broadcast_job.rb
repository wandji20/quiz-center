class BroadcastJob
  include Sidekiq::Job

  def perform(answered_question_id, user_id)
    current_user = User.find_by(id: user_id)
    answered_question = AnsweredQuestion.find(answered_question_id)
    send_broadcast(answered_question, current_user.email)
  end

  private

  # create serialized question and answered question and broadcast them
  def send_broadcast(answered_question, email)
    serialized_answered_question = ActiveModelSerializers::Adapter::Json.new(
      AnsweredQuestionSerializer.new(answered_question)
    )
    question = ActiveModelSerializers::Adapter::Json.new(
      QuestionSerializer.new(answered_question.question)
    )
    ActionCable.server.broadcast(
      "answered_question_#{email}",
      { answered_question: serialized_answered_question, question: question }
    )
  end
end
