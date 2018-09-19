require 'rails_helper'

RSpec.describe "Order API", type: :request do

    let!(:shop) { create(:shop) }
    let!(:items) { create_list(:item, 5, shop_id: shop.id) }
    let!(:head) { { 'Authorization' => generate_token(shop.id) } }
    let!(:order_item_ids) { items[0 .. 3].map { |x| x.id } }
    let!(:orders) { create_list(:order, 2, shop_id: shop.id, item_ids: order_item_ids) }
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
        it 'returns order and its items' do
            expect(json).not_to be_empty
            expect(json['order']['id']).to eq(order_id)
            expect(json['order']['items'].size).to eq(order_item_ids.length)
        end
    end

    # describe "POST /orders" do
    #     let(:valid_order) { { item_ids: order_item_ids } }
    #     before { post '/orders', params: valid_order, headers: head }
    #     it 'returns order object' do
    #         expect(json).not_to be_empty
    #         expect(json['total']).to eq("22")
    #         expect(json['num_item'].to eq("3"))
    #     end
    # end

    # describe "PUT /orders:id" do
    #     let(:qstring) {{ item_ids: [ order_item_ids.first ] }}
    #     before {put "/orders/#{order_id}", params: qstring, headers: head }

    #     it 'update item' do
    #         expect(json).not_to be_empty
    #         expect(json['id']).to eq(order_id)
    #     end

    #     it 'return status 202' do
    #         expect(response).to have_http_status(202)
    #     end
    # end

    # describe "DELETE /orders" do
    #     before { delete "/orders/#{order_id}", params: {}, headers: head }

    #     it 'returns status 204' do
    #         expect(response).to have_http_status(204)
    #     end
    # end
end