# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:name) { |n| "Tag#{n}" }
  sequence(:taggings_count) {|n| "#{n}".to_i}

  factory :tag, class: ActsAsTaggableOn::Tag do    
    name
    taggings_count  
  end
end
