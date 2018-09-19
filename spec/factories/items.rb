FactoryBot.define do
    factory :item do
        name { Faker::Name.name }
        price { rand() * 100 }
        shop
    end
end