class Public::HomesController < Public::ApplicationController
  allow_unauthenticated_access only: %i[top about]
  def top
    @genres = Genre.all
    @items = Item.where(is_active: true).order(created_at: :desc).limit(4)
  end

  def about
  end

end
