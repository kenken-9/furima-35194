class BuysController < ApplicationController
  
  def index
  end

  def create
    @buy = Buy.create(buy_params)
    Address.create(address_params)
    redirect_to root_path
  end

  private

  def buy_params
    params.merge(user_id: current_user.id , product_id: current_product.id)
  end

  def address_params
    params.permit(:postal_code, :area_id, :municipality, :block_number, :building_name, :phone_number).merge(buy_id: @buy.id)
  end
  
end
