class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
  
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true)
    else
      @items = Item.where(is_active: true).page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = Cart.new
  end
  
end
