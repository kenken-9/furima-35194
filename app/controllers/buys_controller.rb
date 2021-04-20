class BuysController < ApplicationController
  before_action :set_product , only:[:create, :index]
  before_action :authenticate_user!, only:[:index, :create]
  before_action :set_path, only:[:index, :create]

  def index
    @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
      pay_item 
      @buy_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: buy_params[:token],
      currency: "jpy"
      )
  end

  def buy_params
    params.require(:buy_address).permit(:postal_code, :area_id, :municipality, :block_number, :building_name, :phone_number).merge(user_id: current_user.id, product_id: params[:product_id],token: params[:token])
  end

  def set_path
    if (@product.user_id == current_user.id) || @product.buy.present?
      redirect_to root_path
     end
  end
end
