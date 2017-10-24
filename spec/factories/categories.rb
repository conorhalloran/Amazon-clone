FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::Beer.hop} #{n}" }
  end
end
