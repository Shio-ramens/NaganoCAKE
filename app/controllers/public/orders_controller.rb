class Public::OrdersController < Public::ApplicationController
  skip_before_action :require_authentication, only: [:new, :confirm, :create, :thanks]
  def new
    @order = Order.new
    @addresses = []
  end

  def confirm
    @order = Order.new
    @order.payment_method = order_params[:payment_method]
    
    # 2. ラジオボタンでどれが選ばれたかによって、@order に入れる住所を分岐させる準備
    #（※ここの中身は次回以降じっくり作るので、まずはエラーを消すためにガワだけ書きます）
    case order_params[:address_option]
    when "0"
      # ご自身の住所が選ばれたとき
    when "1"
      # 登録済住所が選ばれたとき
    when "2"
      # 新しいお届け先が選ばれたとき
      @order.postal_code = order_params[:postal_code]
      @order.address = order_params[:address]
      @order.name = order_params[:name]
    end

    @cart_item = []
  end

  def create
    redirect_to thanks_orders_path
  end

  def thanks
    
  end

  def index
  end

  def show
  end

  private

  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name, :address_option, :address_id)
  end

end
