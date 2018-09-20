class Lineitem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, :quantities, presence: true
  after_validation :set_price!

  def set_price!
    self.price = self.product.price
  end
end
