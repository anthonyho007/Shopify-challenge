class AuthenticateShop
    def initialize(name, password)
        @name = name
        @password = password
    end

    def call
        if shop
            ShopToken.encode(shop_id: shop.id)
        end
    end

    attr_reader :name, :password

    def shop
        shop = Shop.find_by(name: name)
        if shop && shop.authenticate(password)
            return shop
        end
        raise(ExceptionHandler::AuthError, ErrorMessage.credential_invalid)
    end
end