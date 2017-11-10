class Api::V1::ProductsController < Api::BaseController

    protect_from_forgery with: :null_session

    def index
        @products = Product.order(created_at: :desc).limit(10)
        render json: @products 
    end

    def show
        product = Product.find params[:id]
        render json: product
    end

    def create
        product = Product.new product_params

        if product.save
            render json: product
            else
            render json: { errors: product.errors.full_messages }
        end
    end

    def destroy
        product = Product.find_by_id params[:id]
        if product
            product.destroy
            render json: {success: true}
        else
            render json: { errors: ['Product does\'t exist'] }
        end
    end

    def update
        product = Product.find params[:id]
        if product.update product_params
            render json: {success: true}
        else
            render json: { errors: product.errors.full_messages }
        end
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :category_id, {tag_ids: []})
    end
end
