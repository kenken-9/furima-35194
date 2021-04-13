class ProductsController < ApplicationController
    before_action :authenticate_user!, only:[:new]

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

private

def product_params
    params.permit(:image, :name, :text, :price, :category_id, :condition_id, :fee_id, :area_id, :ship_id ).merge(user_id: current_user.id)
end

end
