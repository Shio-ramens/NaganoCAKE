class Public::CartItemsController < Public::ApplicationController
  def index
      @cart_items = Cart.where(customer_id: current_customer.id).includes(:item)
  end

  def create
    item = Item.find(params[:item_id])

    cart_item = Cart.find_by(
      customer_id: current_customer.id,
      item_id: item.id
    )

    if cart_item
      cart_item.amount += params[:amount].to_i
      cart_item.save
    else
      Cart.create(
        customer_id: current_customer.id,
        item_id: item.id,
        amount: params[:amount].to_i
      )
    end

    redirect_to cart_items_path
  end

  def update
    cart = Cart.find(params[:id])
    cart.update(amount: params[:cart][:amount])

    redirect_to cart_items_path
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy

    redirect_to cart_items_path
  end
end
