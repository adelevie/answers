# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answers_answer, class: Answers::Answer do
    need_to_know "MyText"
    text "MyText"
    in_language "MyString"
    question nil
  end
end
