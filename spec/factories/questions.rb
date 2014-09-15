# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    sequence(:text) { Faker::Lorem.sentence }
    in_language "MyString"
  end
end
