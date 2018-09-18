FactoryBot.define do
    factory :shop do
        name { Faker::Name.name }
        password 'foolb'
    end
end