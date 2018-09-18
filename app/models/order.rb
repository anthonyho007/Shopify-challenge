class Order < ApplicationRecord
    belongs_to :shop
    has_and_belongs_to_many :items

    validates :shop_id, presence: true
end
