class Item < ApplicationRecord
    belongs_to :shop
    has_many :placements
    has_many :orders, through: :placements

    validates :shop_id, :name, :price, presence: true
end
