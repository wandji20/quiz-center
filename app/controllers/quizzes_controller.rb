class QuizzesController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @quizzes = Quiz.all
    render @quizzes
  end
end
