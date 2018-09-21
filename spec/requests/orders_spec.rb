require 'rails_helper'

RSpec.describe "Order API", type: :request do

    let!(:shop) { create(:shop) }
    let!(:shop2) { create(:shop) }
    let!(:products) { create_list(:product, 5, shop_id: shop.id) }
    let!(:head) { { 'Authorization' => generate_token(shop.id) } }
    let!(:order_products) { products[0 .. 3] }
    let!(:order) { create(:order, shop_id: shop.id)}
    let!(:lineitem1) { create(:lineitem, order_id: order.id, product_id: order_products.first.id, quantities: 2, price: order_products.first.price) }

    let!(:order_id) { order.id }
    describe "GET /orders" do
        before { get "/orders", params: {}, headers: head }
        it "returns all orders from a shop" do
            expect(json).not_to be_empty
            expect(json['orders'].size).to eq(1)
        end

        it "returns status 200" do
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /orders/:id" do
        before { get "/orders/#{order_id}", params: {}, headers: head }
        it 'returns order and its products' do
            expect(json).not_to be_empty
            expect(json['order']['id']).to eq(order_id)
            expect(json['order']['lineitems'].size).to eq(1)
            expect(json['order']['lineitems'][0]['product_id']).to eq(order_products.first.id)
            expect(json['order']['lineitems'][0]['quantities']).to eq(2)
            expect(json['order']['lineitems'][0]['price']).to eq(order_products.first.price.to_s)
        end
    end

    describe "POST /orders" do

        let(:product_ids_quantities) { [
            {
                "product_id": order_products.second.id,
                "quantities": 3
            },
            {
                "product_id": order_products.third.id,
                "quantities": 2
            }
        ] }
        let(:valid_order) { { product_ids_and_quantities: product_ids_quantities } }
        before { post '/orders', params: valid_order, headers: head }
        it 'returns order object' do
            expect(json).not_to be_empty
            total = order_products.second.price * 3 + order_products.third.price * 2
            expect(json['order']['total']).to eq(total.to_s)
        end
    end

    describe "PUT /orders:id" do
        let(:product_ids_quantities) { [
            {
                "product_id": order_products.second.id,
                "quantities": 3
            },
            {
                "product_id": order_products.third.id,
                "quantities": 2
            }
        ] }
        let(:qstring) {{ product_ids_and_quantities: product_ids_quantities }}
        before {put "/orders/#{order_id}", params: qstring, headers: head }

        it 'update product' do
            expect(json).not_to be_empty
            expect(json['order']['id']).to eq(order_id)
            expect(json['order']['lineitems'].size).to eq(2)
        end

        it 'return status 202' do
            expect(response).to have_http_status(202)
        end
    end

    describe "DELETE /orders" do
        before { delete "/orders/#{order_id}", params: {}, headers: head }

        it 'returns status 204' do
            expect(response).to have_http_status(204)
        end
    end
end