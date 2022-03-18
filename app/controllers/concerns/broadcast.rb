module Broadcast
  extend ActiveSupport::Concern

  def send_broadcast(answered_question)
    answered_question = ActiveModelSerializers::Adapter::Json.new(
      AnsweredQuestionSerializer.new(answered_question) 
    )
    ActionCable.server.broadcast(
      "answered_question_#{current_user.email}", 
      answered_question
    )
  end

  def verify_answered_question_existence
    answered_question = current_user.answered_questions.where(
      'question_id = ? AND quiz_id = ?', 
      answered_question_params[:question_id], 
      answered_question_params[:quiz_id]
    ).take

   if answered_question
    send_broadcast(answered_question)
    json_response({ notice: 'Ok'})
   end
    
  end
end