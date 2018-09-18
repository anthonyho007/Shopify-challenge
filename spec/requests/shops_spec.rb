require 'rails_helper'

RSpec.describe 'Shops Api', type: :request do
    let!(:shops) { create_list(:shop, 2) }
    let!(:shop_id) { shops.first.id }

    # describe 'GET /shops' do
    #     before { get '/shops' }

    #     it 'returns shops' do
    #         expect(json).not_to be_empty
    #         expect(json.size).to eq(2)
    #     end

    #     it 'returns status 200' do
    #         expect(response).to have_http_status(200)
    #     end
    # end

    describe 'GET /shops/:id' do
        before { get "/shops/#{shop_id}" }

        it 'returns shop' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(shop_id)
        end
    end

    describe 'PUT /shops/:id' do
        let(:qstring) { { name: 'tim' } }

        before { put "/shops/#{shop_id}", params: qstring }

        it 'update shop' do
            expect(response.body).to be_empty
        end

        it 'returns status 204' do
            expect(response).to have_http_status(204)
        end
    end

    describe 'DELETE /shops/:id' do
        before { delete "/shops/#{shop_id}" }

        it 'returns status 204' do
            expect(response).to have_http_status(204)
        end
    end
end