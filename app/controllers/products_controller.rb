class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  
  
  
  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new product_params
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
    @review   = Review.new
  end

  def index
    @products = Product.order(created_at: :desc)
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    return head :unauthorized unless can?(:update, @product)
    @product = Product.find params[:id]
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  private

  def get_categories
    @categories = Category.all
  end


  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end

  def authorize_user!
    unless can?(:manage, @product)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end


  ############# END #############
end
