FactoryGirl.define do
  factory :product do
    sequence(:title) {|n| "#{Faker::Beer.name} - #{n}"}
    description "#{Faker::Hacker.say_something_smart}"
    price 10
    sale_price 10
    association :user, factory: :user
    association :category, factory: :category
    end
end
