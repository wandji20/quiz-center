require 'rails_helper'

RSpec.describe "AnsweredQuestions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/answered_questions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/answered_questions/update"
      expect(response).to have_http_status(:success)
    end
  end

end
