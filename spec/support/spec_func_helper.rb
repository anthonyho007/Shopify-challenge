module SpecFuncHelper
    def json
        JSON.parse(response.body)
    end

    def generate_token(shop_id)
        ShopToken.encode(shop_id: shop_id)
    end

    def generate_expired_token(shop_id)
        ShopToken.encode({ shop_id: shop_id }, (Time.now_to_i - 20))
    end

    def get_valid_header
        {
            "Authorization" => generate_token(shop.id),
            "Content-Type" => "application/json"
        }
    end

    def get_invalid_header
        {
            "Authorization" => nil,
            "Content-Type" => "application/json"
        }
    end
end