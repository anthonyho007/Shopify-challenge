class CreateLineitems < ActiveRecord::Migration[5.2]
  def change
    create_table :lineitems do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantities

      t.timestamps
    end
  end
end
