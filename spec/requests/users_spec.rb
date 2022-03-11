require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      user: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end

  let(:invalid_attributes) do
    {
      user: {
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end
  let(:user) { create(:user) }
  let(:header) { valid_headers(user.id) }
  describe 'POST /create' do
    context 'valid attributes' do
      it 'returns http success' do
        post sign_up_path, params: valid_attributes, as: :json
        expect(response.body).to match(/Authorization/)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid attributes' do
      it 'returns http bad request' do
        post sign_up_path, params: {}, as: :json
        expect(response.body).to match(/is missing or invalid/)
        expect(response).to have_http_status(400)
      end

      it 'returns http unprocessable entity' do
        post sign_up_path, params: invalid_attributes, as: :json
        expect(response.body).to match(/name can't be blank/)
        expect(response).to have_http_status(422)
      end
    end
  end

  # describe 'GET /show' do
  #   it 'returns http success' do
  #     get '/users/show'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
