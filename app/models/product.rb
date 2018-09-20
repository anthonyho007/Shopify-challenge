class Product < ApplicationRecord
    belongs_to :shop
    has_many :lineitems, dependent: :destroy
    has_many :orders, through: :lineitems

    validates :shop_id, :name, :price, presence: true
end
