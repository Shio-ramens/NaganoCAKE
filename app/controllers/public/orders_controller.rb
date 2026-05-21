class Public::OrdersController < Public::ApplicationController
  skip_before_action :require_authentication, only: [:new, :confirm, :create, :thanks, :index, :show]
  def new
    @order = Order.new
    @addresses = []
  end

  def confirm
    @order = Order.new(order_params)
  
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    
    elsif params[:order][:address_option] == "2"
    end

    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
    redirect_to thanks_orders_path
  end

  def thanks

  end

  def index
    @orders = []
  end

  def show
    @order = Order.new(
      postal_code: "150-0041",
    address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階",
    name: "山田花子",
    payment_method: "transfer" 
    )
  end

  private

  def order_params
   params.require(:order).permit(:payment_method, :select_address, :postal_code, :address, :name)
  end

end
