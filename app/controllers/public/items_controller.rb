class Public::ItemsController < Public::ApplicationController

  def index
    @genres = Genre.all
  
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true)
    else
      @items = Item.where(is_active: true)
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end
end
