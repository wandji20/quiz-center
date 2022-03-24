class QuizzesController < ApplicationController
  
  api :GET, '/quizzes', 'Quizzes'
  def index
    render json: Quiz.all, adapter: :json, status: :ok
  end
end
