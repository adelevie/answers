# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag, class: ActsAsTaggableOn::Tag do    
    sequence(:name) { |n| "tag#{n}" }
    sequence(:taggings_count) {|n| "#{n}".to_i}
  end
end
