require 'rails_helper'

RSpec.describe User, type: :model do
  let(:subject) { create(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(2).is_at_most(50) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(72) }
  it { should validate_presence_of(:password_confirmation) }
  it { should validate_length_of(:password_confirmation).is_at_least(6).is_at_most(72) }

  it { should have_many(:answered_questions) }
end
