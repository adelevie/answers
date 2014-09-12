FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password                 "Mahalo43"
    password_confirmation    "Mahalo43"
    is_editor                true
    is_writer                true
    is_admin                 false

    factory :admin do
      is_admin               true
    end

    factory :editor do
      is_editor              true
      is_writer              false
      is_admin               false
    end

    factory :writer do
      is_writer              true
      is_editor              false
      is_admin               false
    end

    factory :user_no_abilities do
      is_writer              false
      is_editor              false
      is_admin               false
    end
  end
end