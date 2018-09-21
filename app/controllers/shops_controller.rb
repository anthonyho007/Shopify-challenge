class ShopsController < ApplicationController
    before_action :set_shop, only: [:show, :update, :destroy]

    # def index
    #     @shops = Shop.all
    #     json_response(@shops)
    # end

    # def create
    #     @shop = Shop.create!(shop_params)
    #     json_response(@shop, :created)
    # end

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
        params.permit(:name)
    end

    def set_shop
        @shop = Shop.find(params[:id])
    end
end
