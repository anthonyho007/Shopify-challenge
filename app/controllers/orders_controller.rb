class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update, :destroy]
    before_action :find_products, only: [:create, :update]

    def index
        @orders = current_shop.orders
        json_response(@orders)
    end

    def create
        @order = current_shop.orders.create!()
        @order.products = @order_products
        @order.total = get_total
        json_response(@order, :created)
    end

    def show
        json_response(@order)
    end

    def update
        @order.products = @order_products
        @order.total = get_total
        json_response(@order, :accepted)
    end

    def destroy
        @order.destroy
    end

    private
    def order_params
        params.permit(:product_ids, :total)
    end

    def set_order
        @order = current_shop.orders.find(params[:id])
    end

    def find_products
        @order_products = current_shop.products.find(params[:product_ids])
    end

    def get_total
        return @order_products.map(&:price).sum
    end
end
