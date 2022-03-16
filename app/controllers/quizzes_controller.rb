class QuizzesController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render json: Quiz.all,  adapter: :json, status: :ok
  end
end
