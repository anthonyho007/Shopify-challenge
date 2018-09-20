FactoryBot.define do
    factory :lineitem do
      order
      product
      quantities { 1 }
      price { 1 }
    end
  end