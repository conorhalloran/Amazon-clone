class ReviewsController < ApplicationController
  before_action :find_review, only: [:destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_user!, only: [:destroy]
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
    @review = Review.new review_params
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user = current_user
    @review.save
    redirect_to product_path(@product)
  end

  def destroy
    @product = @review.product  
    @review.destroy
    p @product
    redirect_to product_path(@product), notice: 'Review Deleted'
  end

  private
  def review_params
    params.require(:review).permit(:rating, :body)
  end


  def find_review
    @review = Review.find params[:id]
  end

  def authorize_user!
    unless can?(:crud, @review)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end
end
