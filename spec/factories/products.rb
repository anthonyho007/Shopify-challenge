FactoryBot.define do
    factory :product do
        name { Faker::Name.name }
        price { rand() * 100 }
        shop
    end
end