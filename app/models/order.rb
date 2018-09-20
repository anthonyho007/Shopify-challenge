class Order < ApplicationRecord
    belongs_to :shop
    has_many :lineitems, dependent: :destroy
    has_many :products, through: :lineitems

    validates :shop_id, presence: true
end
