class Order < ApplicationRecord
    belongs_to :shop
    has_many :lineitems, dependent: :destroy
    has_many :products, through: :lineitems

    validates :shop_id, presence: true

    def create_line_items(ids_and_quantities)
        ids_and_quantities.each do |id_and_quantity|
            id = id_and_quantity['product_id']
            quant = id_and_quantity['quantities']
            # puts id_and_quantity
            self.lineitems.create!(product_id: id, quantities: quant)
        end
    end
end
