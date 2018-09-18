class Item < ApplicationRecord
    belongs_to :shop
    has_and_belongs_to_many :orders

    validates :shop_id, :name, :price, presence: true
end
