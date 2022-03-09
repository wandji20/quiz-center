FactoryBot.define do
  factory :quiz do
    title { Quiz::TITLES.sample }
  end
end
