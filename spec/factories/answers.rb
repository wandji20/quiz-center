FactoryBot.define do
  factory :answer do
    value { Faker::Lorem.word }
    is_correct { false }
    question
  end
end
