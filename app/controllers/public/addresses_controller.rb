class Public::AddressesController < ApplicationController

  helper_method :authenticated_customer?
  def authenticated_customer?; false; end

  def index
    @address = Address.new
    @addresses = Address.all 
 end

 def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path, notice:"配送先を登録しました。"
    else
      @addresses = Address.all
      render :index
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "配送先を削除しました。"
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
