FactoryBot.define do
  factory :question do
    description { Faker::Lorem.question }
    points { 1 }
    quiz
  end
end
