require 'rails_helper'

RSpec.describe 'Line Item API', type: :request do
    let!(:shop) { create(:shop) }
    let!(:items) { create_list(:item, 5, shop_id: shop.id) }
    let!(:item1_id) { items.first.id }
    let!(:head) { { 'Authorization' => generate_token(shop.id) } }

    describe 'GET /items' do
        before { get '/items', params:{}, headers: head }
        it 'returns all items from a shop' do
            expect(json).not_to be_empty
            expect(json.size).to eq(5)
        end

        it 'returns status 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /items/:id' do
        before { get "/items/#{item1_id}", params: {}, headers: head }

        it 'returns item' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(item1_id)
            expect(json['name']).to eq(items.first.name)
            expect(json['price']).to eq(items.first.price.to_f.round(2).to_s)
        end
    end

    describe 'POST /items' do
        let(:valid_item) { {
                name: "Jack Daniel",
                price: 23.232} }

        context 'valid item params' do
            before { post '/items', params: valid_item, headers: head }
            it 'returns items object' do
                expect(json).not_to be_empty
                expect(json['name']).to eq("Jack Daniel")
                expect(json['price']).to eq("23.23")
            end
        end
    end

    describe 'PUT /items/:id' do
        let(:qstring) { { price: 12.22 } }
        before {put "/items/#{item1_id}", params: qstring, headers: head }

        it 'update item' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(item1_id)
            expect(json['name']).to eq(items.first.name)
            expect(json['price']).to eq("12.22")
        end

        it 'return status 202' do
            expect(response).to have_http_status(202)
        end
    end

    describe 'DELETE /items/:id' do
        before { delete "/items/#{item1_id}", params: {}, headers: head }

        it 'returns status 204' do
            expect(response).to have_http_status(204)
        end
    end
end