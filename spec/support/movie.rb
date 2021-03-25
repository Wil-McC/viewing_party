FactoryBot.define do
  factory :movie do
    name { Faker::Movie.title }
    api_id { Faker::Number.number(digits: 6) }
  end
end
