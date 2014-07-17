# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    need_to_know "MyText"
    text "MyText"
    url "MyString"
    in_language "MyString"
    question nil
  end
end
