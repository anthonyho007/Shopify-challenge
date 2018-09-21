class ShopsController < ApplicationController
    before_action :set_shop, only: [:show, :update, :destroy]

    def show
        json_response(@shop)
    end

    def update
        @shop.update(shop_params)
        json_response(@shop)
    end

    def destroy
        @shop.destroy
        head :no_content
    end

    private
    def shop_params
        params.permit(:name, :password)
    end

    def set_shop
        @shop = current_shop
    end
end
