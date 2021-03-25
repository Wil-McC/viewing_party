FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password_digest { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
  end 
end
