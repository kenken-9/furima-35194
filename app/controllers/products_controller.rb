class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_product, only: [:edit, :show]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @products = Product.order("created_at DESC")
  end

  def show
  end

  def edit
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
        redirect_to product_path(@product)
    else 
        render :edit
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:image, :name, :text, :price, :category_id, :condition_id, :fee_id, :area_id, :ship_id).merge(user_id: current_user.id)
  end
end
