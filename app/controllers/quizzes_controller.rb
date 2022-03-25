class QuizzesController < ApplicationController
  api :GET, '/quizzes', 'Quizzes'
  def index
    # call interaction/quizzes/index
    outcome = Quizzes::Index.run({ current_user: current_user })
    json_response(outcome.result)
  end
end
