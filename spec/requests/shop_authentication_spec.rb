require 'rails_helper'

RSpec.describe 'ShopAuthentication', type: :request do
    let(:shop) { create(:shop) }
    let(:head) { get_valid_header.except('Authorization') }

    let(:valid_cred) do
        {
            name: shop.name,
            password: shop.password
        }.to_json
    end
    let(:invalid_cred) do
        {
            name: "tony",
            password: "sup"
        }.to_json
    end

    describe 'POST /signin' do
        context 'valid auth request' do
            before { post '/signin', params: valid_cred, headers: head }
            it 'returns oauth token' do
                expect(json['token']).not_to be_nil
            end
        end

        context 'invalid auth request' do
            before { post '/signin', params: invalid_cred, headers: head }
            it 'returns error message' do
                expect(json['message']).to match('Credential Invalid')
            end
        end
    end

    describe 'POST /signup' do
        context 'invalid signup request' do
            before { post '/signup', params: {}, headers: head }

            it 'returns status 422' do
                expect(response).to have_http_status(422)
            end
        end

        context 'valid signup request' do
            before { post '/signup', params: valid_cred, headers: head }

            it 'creates a shop' do
                expect(json['name']).to eq(shop.name)
            end
    
            it 'returns oauth token' do
                expect(json['token']).not_to be_nil
            end
    
            it 'returns status 201' do
                expect(response).to have_http_status(201)
            end
        end
    end
end