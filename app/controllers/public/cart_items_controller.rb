class Public::CartItemsController < Public::ApplicationController
  def index
      @cart_items = CartItem.where(customer_id: current_customer.id).includes(:item)
  end

def create

  item_id = params[:cart_item][:item_id]

  add_amount = params[:cart_item][:amount].to_i

  @existing_cart_item = current_customer.cart_items.find_by(item_id: item_id)

  if @existing_cart_item.present?

    new_amount = @existing_cart_item.amount + add_amount

    new_amount = 99 if new_amount > 99

    @existing_cart_item.update(amount: new_amount)
    redirect_to cart_items_path
  else
    @cart_item = current_customer.cart_items.new(
      item_id: item_id,
      amount: add_amount
    )
    
    if @cart_item.save
      redirect_to cart_items_path
    else

      flash[:alert] = "個数を選択してください"
      redirect_to item_path(item_id)
    end
  end
end

def update
  cart = current_customer.cart_items.find(params[:id])
  # 変更後の値が10を超えていたら10に固定
  amount = params[:cart_item][:amount].to_i
  amount = 99 if amount > 99
  
  cart.update(amount: amount)
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
