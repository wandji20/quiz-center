FactoryBot.define do
  factory :user do
    username { 'username' }
    email { Faker::Internet.email }
    password { '111111' }
    password_confirmation { '111111' }
  end
end
