# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shop = Shop.create!(name: 'Anthony Ho', password: 'foolb')
product = Product.create!(name: 'CherryMx Blue Infinity keyboard', price: 12.22, shop_id: shop.id)
order = Order.create!(shop_id: shop.id)
lineitem = Lineitem.create!(order_id: order.id, product_id: product.id, quantities: 3)