class Public::ItemsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  def index
    @genres = Genre.all
  
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true).page(params[:page]).per(8)
    else
      @items = Item.where(is_active: true).page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = Cart.new
  end

  private

    def authenticated_customer?
      session[:customer_id].present?
    end
  end

