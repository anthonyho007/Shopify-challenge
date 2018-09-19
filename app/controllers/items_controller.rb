class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]

    def index
        @items = current_shop.items
        json_response(@items)
    end

    def create
        @item = current_shop.items.create!(item_params)
        json_response(@item, :created)
    end

    def show
        json_response(@item)
    end

    def update
        @item.update(item_params)
        json_response(@item, :accepted)
    end

    def destroy
        @item.destroy
        head :no_content
    end

    private
    def item_params
        params.permit(:name, :price)
    end

    def set_item
        @item = Item.find(params[:id])
    end
end
