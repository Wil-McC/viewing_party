FactoryBot.define do
  factory :party do
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    user
    movie
  end
end
