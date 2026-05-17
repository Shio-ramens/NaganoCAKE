class Public::OrdersController < Public::ApplicationController
  skip_before_action :require_authentication, only: [:new, :confirm, :create, :thanks, :index, :show]
  def new
    @order = Order.new
    @addresses = []
  end

  def confirm
    

    @order = Order.new(order_params)
    @order.payment_method = order_params[:payment_method]
    
    # 2. ラジオボタンでどれが選ばれたかによって、@order に入れる住所を分岐させる準備
    #（※ここの中身は次回以降じっくり作るので、まずはエラーを消すためにガワだけ書きます）
    case params[:order][:select_address]
    when "0"
      @order.postal_code = "123-4567"
      @order.address     = "長野県長野市ケーキ町1-1"
      @order.name        = "ながの 太郎"
    when "1"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address     = address.address
      @order.name        = address.name
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
    @orders = []
  end

  def show
    @order = Order.new(
      postal_code: "150-0041",
    address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階",
    name: "山田花子",
    payment_method: "transfer" # 一旦文字で置いておきます
    )
  end

  private

  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
