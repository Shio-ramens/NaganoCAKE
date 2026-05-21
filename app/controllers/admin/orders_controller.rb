class Admin::OrdersController < Admin::ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスを更新しました"
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page]).per(10).order(created_at: :desc)
  end
  private

  def order_params
    params.require(:order).permit(:status)
  end
end

