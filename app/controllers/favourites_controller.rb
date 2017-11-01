class FavouritesController < ApplicationController
    before_action :authenticate_user!

    def create
        product = Product.find params[:product_id]
        favourite = Favourite.new(user: current_user, product: product)
        if !can? :favourite, product
            head :unauthorized
        elsif favourite.save
            redirect_to product, notice: 'Thanks for Favouring this Product!'
        else
            redirect_to product, alert: 'You already favourited the product.'
        end
    end

    def destroy
        favourite = Favourite.find params[:id]
        if can? :destroy, favourite
            favourite.destroy
            redirect_to favourite.product, notice: 'Favourite removed'
        else
            head :unauthorized
        end
    end
end