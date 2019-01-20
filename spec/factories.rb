FactoryBot.define do

  factory :campaign do
    name { Faker::Company.name }
    target_amount  { (rand(1000..100000)/100).ceil * 100}
    sector { Faker::Company.industry }
    country { create(:country) }
  end

  factory :country do
    name { Faker::Address.country }
  end

  factory :investment do
    amount { rand(100..1000) }
    campaign { create(:campaign) }
  end
end
