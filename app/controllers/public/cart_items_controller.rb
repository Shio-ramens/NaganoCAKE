class Public::CartItemsController < Public::ApplicationController
  def index
      @cart_items = CartItem.where(customer_id: current_customer.id).includes(:item)
  end

  def create
    @existing_cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])

    if @existing_cart_item.present?
      add_amount = params[:cart_item][:amount].to_i
      new_amount = @existing_cart_item.amount + add_amount
      @existing_cart_item.update(amount: new_amount)
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new
      @cart_item.customer_id = current_customer.id 
      @cart_item.item_id = params[:cart_item][:item_id] 
      @cart_item.amount = params[:cart_item][:amount].to_i
      
      if @cart_item.save
        redirect_to cart_items_path
      else
        redirect_to item_path(params[:cart_item][:item_id])
      end
    end
  end

  def update
    cart = CartItem.find(params[:id])
    cart.update(amount: params[:cart_item][:amount])

    redirect_to cart_items_path
  end

  def destroy
    cart = CartItem.find(params[:id])
    cart.destroy

    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    redirect_to cart_items_path
  end
end
