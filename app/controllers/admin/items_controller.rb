class Admin::ItemsController < Admin::ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
end
