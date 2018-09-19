class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update, :destroy]

    def index
        @orders = current_shop.orders
        json_response(@orders)
    end

    def show
        json_response(@order)
    end

    private
    def order_params
        params.permit(:item_ids)
    end

    def set_order
        @order = current_shop.orders.find(params[:id])
    end
end
