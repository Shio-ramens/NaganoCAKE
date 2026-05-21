class Public::AddressesController < Public::ApplicationController

  def index
    @address = Address.new
    @addresses = current_customer.addresses
 end

  def create
    @address = current_customer.addresses.new(address_params)

    if @address.save
      redirect_to addresses_path, notice:"配送先を登録しました。"
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "配送先を削除しました。"
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を変更しました。"
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
