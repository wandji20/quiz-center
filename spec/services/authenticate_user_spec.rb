require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_request_obj) { described_class.call(user.email, user.password) }
  subject(:invalid_request_obj) { described_class.call(user.email, 'some password') }

  describe '#call' do
    context 'valid credentials' do
      it 'returns encode jwt token' do
        token = valid_request_obj
        expect(token).to_not be_nil
      end
    end

    context 'invalid credentials' do
      it 'raises AuthenticationError' do
        expect { invalid_request_obj }
          .to raise_error(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
    end
  end
end