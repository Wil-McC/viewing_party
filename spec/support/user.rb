FactoryBot.define do
  factory :user, aliases: [:friend] do
    email { Faker::Internet.safe_email }
    password { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
  end
end
