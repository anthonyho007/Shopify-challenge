FactoryBot.define do
    factory :shop do
        name { Faker::Name.name }
        password { 'foolb' }

        factory :shop_with_products do
            transient do
                products_count { 5 }
            end

            after(:create) do |shop, evaluator|
                create_list(:product, evaluator.products_count, shop: shop)
            end
        end
    end
end