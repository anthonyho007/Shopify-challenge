require 'rails_helper'

RSpec.describe OauthRequest do
    let(:shop) { create(:shop) }
    let(:head) { { 'Authorization' => generate_token(shop.id) } }

    subject(:invalid_req) { described_class.new({}) }
    subject(:valid_req) { described_class.new(head) }
    
    describe '#api call' do
        context 'do valid request' do
            it 'gives shop object' do
                res = valid_req.call
                expect(res[:shop]).to eq(shop)
            end
        end

        context 'do invalid request' do
            it 'raises a token error' do
                expect { invalid_req.call }
                    .to raise_error(ExceptionHandler::TokenError, 'Token Missing')
            end
        end
    end
end