require 'rails_helper'

RSpec.describe 'Product API', type: :request do
    let!(:shop) { create(:shop) }
    let!(:products) { create_list(:product, 5, shop_id: shop.id) }
    let!(:product1_id) { products.first.id }
    let!(:head) { { 'Authorization' => generate_token(shop.id) } }

    describe 'GET /products' do
        before { get '/products', params:{}, headers: head }
        it 'returns all products from a shop' do
            puts json
            expect(json).not_to be_empty
            expect(json['products'].size).to eq(5)
        end

        it 'returns status 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /products/:id' do
        before { get "/products/#{product1_id}", params: {}, headers: head }

        it 'returns product' do
            expect(json).not_to be_empty
            puts json
            expect(json['id']).to eq(product1_id)
            expect(json['name']).to eq(products.first.name)
            expect(json['price']).to eq(products.first.price.to_f.round(2).to_s)
        end
    end

    describe 'POST /products' do
        let(:valid_product) { {
                name: "Jack Daniel",
                price: 23.232} }

        context 'valid product params' do
            before { post '/products', params: valid_product, headers: head }
            it 'returns products object' do
                expect(json).not_to be_empty
                puts json
                expect(json['name']).to eq("Jack Daniel")
                expect(json['price']).to eq("23.23")
            end
        end
    end

    describe 'PUT /products/:id' do
        let(:qstring) { { price: 12.22 } }
        before {put "/products/#{product1_id}", params: qstring, headers: head }

        it 'update product' do
            expect(json).not_to be_empty
            puts json
            expect(json['id']).to eq(product1_id)
            expect(json['name']).to eq(products.first.name)
            expect(json['price']).to eq("12.22")
        end

        it 'return status 202' do
            expect(response).to have_http_status(202)
        end
    end

    describe 'DELETE /products/:id' do
        before { delete "/products/#{product1_id}", params: {}, headers: head }

        it 'returns status 204' do
            expect(response).to have_http_status(204)
        end
    end
end