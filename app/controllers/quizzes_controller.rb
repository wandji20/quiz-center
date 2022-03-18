class QuizzesController < ApplicationController
  skip_before_action :authenticate_request

  api :GET, '/quizzes', 'Quizzes'
  def index
    render json: Quiz.all, adapter: :json, status: :ok
  end
end
