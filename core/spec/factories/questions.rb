# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question, class: Answers::Question do
    text "How can I check my license application?"
    in_language "MyString"
  end
end
