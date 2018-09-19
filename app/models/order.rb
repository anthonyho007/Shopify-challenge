class Order < ApplicationRecord
    belongs_to :shop
    has_many :placements
    has_many :items, through: :placements

    validates :shop_id, presence: true
end
