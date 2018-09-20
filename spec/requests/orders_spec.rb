require 'rails_helper'

RSpec.describe "Order API", type: :request do

    let!(:shop) { create(:shop) }
    let!(:products) { create_list(:product, 5, shop_id: shop.id) }
    let!(:head) { { 'Authorization' => generate_token(shop.id) } }
    let!(:order_products) { products[0 .. 3] }
    let!(:order_product_ids) { order_products.map { |x| x.id } }
    let!(:orders) { create_list(:order, 2, shop_id: shop.id, product_ids: order_product_ids) }
    let!(:order_id) { orders.first.id }
    describe "GET /orders" do
        before { get "/orders", params: {}, headers: head }
        it "returns all orders from a shop" do
            expect(json).not_to be_empty
            expect(json['orders'].size).to eq(2)
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
            expect(json['order']['products'].size).to eq(order_product_ids.length)
        end
    end

    describe "POST /orders" do
        let(:valid_order) { { product_ids: order_product_ids, total: order_products.map(&:price).sum } }
        before { post '/orders', params: valid_order, headers: head }
        it 'returns order object' do
            expect(json).not_to be_empty
            expect(json['order']['total']).to eq(order_products.map(&:price).sum.to_s)
        end
    end

    describe "PUT /orders:id" do
        let(:qstring) {{ product_ids: [ order_product_ids.first ] }}
        before {put "/orders/#{order_id}", params: qstring, headers: head }

        it 'update product' do
            expect(json).not_to be_empty
            expect(json['order']['id']).to eq(order_id)
            expect(json['order']['products'].size).to eq(1)
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