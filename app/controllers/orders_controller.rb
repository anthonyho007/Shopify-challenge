class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update, :destroy]
    def index
        @orders = current_shop.orders
        updateOrders
        json_response(@orders)
    end

    def create
        @order = current_shop.orders.create!()
        @order.create_line_items(params[:product_ids_and_quantities])
        @order.total = get_total(@order.lineitems)
        json_response(@order, :created)
    end

    def show
        json_response(@order)
    end

    def update
        @order.lineitems.destroy_all
        @order.create_line_items(params[:product_ids_and_quantities])
        @order.total = get_total(@order.lineitems)
        json_response(@order, :accepted)
    end

    def destroy
        @order.destroy
    end

    private
    def order_params
        params.permit(:product_ids_and_quantities, :total)
    end

    def set_order
        @order = current_shop.orders.find(params[:id])
        @order.total = get_total(@order.lineitems)
    end

    def get_total(lineitems)
        total = 0
        lineitems.each do |lineitem|
            total += lineitem.price * lineitem.quantities
        end
        return total
    end

    def updateOrders
        @orders.each do |order|
            order.total = get_total(order.lineitems)
        end
    end
end
