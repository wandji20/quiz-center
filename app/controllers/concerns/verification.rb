# verify if signed in user already has an answered question with params question_id and params quiz_id.
# broadcasts' answsered question if it already exist
module Verification
  extend ActiveSupport::Concern

  def verify_answered_question_existence
    answered_question = current_user.answered_questions.where(
      'question_id = ? AND quiz_id = ?',
      answered_question_params[:question_id],
      answered_question_params[:quiz_id]
    ).take
    return unless answered_question

    json_response({ notice: 'Ok' })
    BroadcastJob.perform_async(
      answered_question.id, current_user.id
    )
  end
end
