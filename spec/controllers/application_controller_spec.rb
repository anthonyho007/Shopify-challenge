require "rails_helper"

RSpec.describe ApplicationController, type: :controller do

    let(:shop) { create(:shop) }
    let(:head) { { 'Authorization' => generate_token(shop.id) } }
    let(:invalid_head) { { 'Authorization' => nil } }

    describe '#authorized request' do

        context "when token is valid" do
            before { allow(request).to receive(:headers).and_return(head) }
            it 'set login shop' do
                expect(subject.instance_eval { validate_request }).to eq(shop)
            end
        end

        context "when token is invalid" do
            before { allow(request).to receive(:headers).and_return(invalid_head) }
            
            it "throw TokenError error" do
                expect { subject.instance_eval { validate_request } }.
                    to raise_error(ExceptionHandler::TokenError, 'Token Missing')
            end
        end

    end
end