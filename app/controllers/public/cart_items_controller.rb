class Public::CartItemsController < Public::ApplicationController
  def index
      @cart_items = CartItem.where(customer_id: current_customer.id).includes(:item)
  end

  def create
    @cart_item = CartItem.new
    @cart_item.customer_id = current_customer.id # IDの直接代入はOKです
    @cart_item.item = Item.find(params[:cart_item][:item_id]) # ここでオブジェクトを渡す
    @cart_item.amount = params[:cart_item][:amount].to_i
    
    if @cart_item.save
      redirect_to cart_items_path
    else
      puts @cart_item.errors.full_messages # ここでエラー詳細が出ます
      redirect_to item_path(params[:cart_item][:item_id])
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
