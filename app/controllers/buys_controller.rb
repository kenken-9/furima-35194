class BuysController < ApplicationController
  
  def index
     @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
        @buy_address.save
        redirect_to root_path
      else
          render :index
      end
  end


  private

  def buy_params
     params.require(:buy_address).permit(:postal_code, :area_id, :municipality, :block_number, :building_name, :phone_number ).merge(user_id: current_user.id, product_id: params[:product_id])
  end
  
end
