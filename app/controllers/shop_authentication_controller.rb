class ShopAuthenticationController < ApplicationController
    skip_before_action :validate_request, only: [:authenticate, :signup]
    def authenticate
        token = AuthenticateShop.new(authenticate_param[:name], authenticate_param[:password]).call
        shop = Shop.find_by(name: authenticate_param[:name])
        json_response(generateResponse(shop, token))
    end

    def authenticate_param
        params.permit(:name, :password)
    end

    def signup
        shop = Shop.create!(shop_params)
        token = AuthenticateShop.new(shop.name, shop.password).call
        json_response(generateResponse(shop, token), :created)
    end

    def shop_params
        params.permit(
            :name,
            :password
        )
    end

    def generateResponse(shop, token)
        response = {
            id: shop.id,
            name: shop.name,
            token: token
        }
        return response
    end
end
