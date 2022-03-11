require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      authentication: {
        email: user.email, password: user.password
      }
    }
  end

  let(:invalid_attributes) do
    {
      authentication: {
        email: user.email, password: 'some password'
      }
    }
  end
  describe 'POST /create' do
    context 'valid attributes' do
      it 'returns http success' do
        post login_path, params: valid_attributes
        expect(response.body).to match(/Authorization/)
        expect(response.body).to match(user.name)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid attributes' do
      it 'returns http unprocessable entity' do
        post login_path, params: invalid_attributes
        expect(response.body).to match(/Invalid credentials/)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
