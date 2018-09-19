FactoryBot.define do
    factory :shop do
        name { Faker::Name.name }
        password { 'foolb' }

        factory :shop_with_items do
            transient do
                items_count { 5 }
            end

            after(:create) do |shop, evaluator|
                create_list(:item, evaluator.items_count, shop: shop)
            end
        end
    end
end