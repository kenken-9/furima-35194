class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  before_action :set_path, only: [:edit, :update, :destroy]
  before_action :sold_out_product, only:[:edit]
  

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
    if @product.update(product_params)
        redirect_to product_path(@product)
    else 
        render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

 def set_path
    unless @product.user_id == current_user.id
      redirect_to root_path
    end
 end

  def product_params
    params.require(:product).permit(:image, :name, :text, :price, :category_id, :condition_id, :fee_id, :area_id, :ship_id).merge(user_id: current_user.id)
  end

  def sold_out_product
    if @product.buy.present?
      redirect_to root_path
    end
  end

 

end
