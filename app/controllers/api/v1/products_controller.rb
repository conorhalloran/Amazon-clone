class Api::V1::ProductsController < ApplicationController
    def index
        @products = Product.order(created_at: :desc).limit(10)
        render json: @products 
    end

    def show
    end
end
