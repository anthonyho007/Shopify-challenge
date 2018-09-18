class OauthRequest
    def initialize(header = {})
        @header = header
    end

    def call
        {
            shop: shop
        }
    end

    private

    attr_reader :header

    def shop
        if decoded_token
            @shop ||= Shop.find(decoded_token[:shop_id])
        end

    rescue ActiveRecord::RecordNotFound => e
        raise(ExceptionHandler::TokenError, ErrorMessage.token_invalid)
    end

    def get_auth_header
        if header['Authorization'].present?
            return header['Authorization'].split(' ').last
        end

        raise(ExceptionHandler::TokenError, ErrorMessage.token_missing)
    end

    def decoded_token
        @decoded_token ||= ShopToken.decode(get_auth_header)
    end
end