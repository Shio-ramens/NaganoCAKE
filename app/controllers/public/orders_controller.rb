class Public::OrdersController < Public::ApplicationController
  skip_before_action :require_authentication, only: [:new, :confirm, :create, :thanks, :index, :show]
  def new
    @order = Order.new
    @addresses = []
  end

  def confirm
  @select_address = params[:order][:select_address]
  
  @order = Order.new(order_params.except(:select_address))

  if @select_address == "0"
    @order.postal_code = current_customer.postal_code
    @order.address     = current_customer.address
    @order.name        = current_customer.last_name + current_customer.first_name
    
  elsif @select_address == "1"
    @address = current_customer.addresses.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address     = @address.address
    @order.name        = @address.name
    
  elsif @select_address == "2"
    @order.postal_code = params[:order][:postal_code]
    @order.address     = params[:order][:address]
    @order.name        = params[:order][:name]
  end

    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      @total += cart_item.item.with_tax_price * cart_item.amount
    end

  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.status = 0
  
    if @order.save
      current_customer.cart_items.each do |cart_item|
        OrderDetail.create!(
          order_id: @order.id,
          item_id: cart_item.item_id,
          price: cart_item.item.with_tax_price, 
          amount: cart_item.amount,
          making_status: 0 
        )
      end
      current_customer.cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :new
    end
  end

  def thanks

  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost)
  end

end
