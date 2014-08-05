FactoryGirl.define do
  factory :contact do
    name Faker::Name.name
    number Faker::Number.number(10)
    url Faker::Internet.url
    address "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state} #{Faker::Address.zip}"
    department Faker::Commerce.department
    description "#{Faker::Company.catch_phrase} + #{Faker::Company.bs}"
  end
end
