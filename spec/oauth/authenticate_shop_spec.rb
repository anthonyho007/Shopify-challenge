require 'rails_helper'

RSpec.describe AuthenticateShop do
    let(:shop) { create(:shop) }

    subject(:valid_auth) { described_class.new(shop.name, shop.password) }

    subject(:invalid_auth) { described_class.new('tony', 'pwd') }

    describe '#api call' do
        context 'with valid cred' do
            it 'return a token' do
                token = valid_auth.call
                expect(token).not_to be_nil
            end
        end

        context 'with invalid cred' do
            it 'throw auth error' do
                expect { invalid_auth.call }
                    .to raise_error(ExceptionHandler::AuthError, 'Credential Invalid')
            end
        end

    end

end