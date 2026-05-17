class Public::OrdersController < Public::ApplicationController
  
  skip_before_action :require_authentication, raise: false

  def new
    @order = Order.new
    @addresses = []
  end

  def confirm
    @order = Order.new(order_params)
    @order.payment_method = order_params[:payment_method]

    case params[:order][:select_address]
    when "0"
      @order.postal_code = "150-0041"
      @order.address     = "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階"
      @order.name        = "山田 花子"
    when "1"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address     = address.address
      @order.name        = address.name
    when "2"
      @order.postal_code = order_params[:postal_code]
      @order.address     = order_params[:address]
      @order.name        = order_params[:name]
    end
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
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

  # 👇 画面（View）のエラーを消すためのダミー定義
  
end