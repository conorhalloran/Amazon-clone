class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_user!, only: [:destory, :edit]
  def new
  end
  
  def create
    # review_params = params.require(:review).permit(:rating, :body)
    # @review   = Review.new review_params
    # @product = Product.find params[:product_id]
    # if @review.save
    #     redirect_to product_path(@product), notice: 'Review Created!'
    #   else
    #     render '/products/show'
    # end
    review_params = params.require(:review).permit(:rating, :body)
    @review = Review.new review_params
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user = current_user
    @review.save
    redirect_to product_path(@product)
  end

  def destroy
    @review = Review.find params[:id]
    @product = @review.product  
    @review.destroy
    redirect_to product_path(@product), notice: 'Review Deleted'
  end

  private
  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end
end
