require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:valid_header) { valid_headers(user.id) }
  let(:invalid_header) { invalid_headers }
  subject(:valid_request_obj) { described_class.call(valid_header) }
  subject(:invalid_request_obj) { described_class.call(invalid_header) }

  describe '#call' do
    context 'valid_request' do
      it 'returns user object' do
        outcome = valid_request_obj
        expect(outcome).to eq(user)
      end
    end

    context 'invalid request' do
      context 'missing token' do
        it 'raises Missing error' do
          expect { invalid_request_obj }
            .to raise_error(ExceptionHandler::MissingToken, Message.missing_token)
        end
      end

      context 'invalid token' do
        let(:header) { valid_headers(5) }
        it 'raises InvalidToken error' do
          expect { described_class.call(header) }
            .to raise_error(ExceptionHandler::InvalidToken, Message.invalid_token)
        end
      end

      context 'expired token' do
        let(:header) { { Authorization: generate_expired_token(user.id) } }
        it 'raises InvalidToken error' do
          expect { described_class.call(header) }
            .to raise_error(ExceptionHandler::InvalidToken, 'Signature has expired')
        end
      end

      context 'fake token' do
        let(:header) { { Authorization: 'some strng' } }
        it 'raises InvalidToken error' do
          expect { described_class.call(header) }
            .to raise_error(ExceptionHandler::InvalidToken, 'Not enough or too many segments')
        end
      end
    end
  end
end
