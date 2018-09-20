class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]

    def index
        @products = current_shop.products
        json_response(@products)
    end

    def create
        @product = current_shop.products.create!(product_params)
        json_response(@product, :created)
    end

    def show
        json_response(@product)
    end

    def update
        @product.update(product_params)
        json_response(@product, :accepted)
    end

    def destroy
        @product.destroy
        head :no_content
    end

    private
    def product_params
        params.permit(:name, :price)
    end

    def set_product
        @product = Product.find(params[:id])
    end
end
