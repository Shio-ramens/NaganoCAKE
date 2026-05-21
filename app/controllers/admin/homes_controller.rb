class Admin::HomesController < Admin::ApplicationController
  def top
    @orders = Order.all.order(created_at: :desc).page(params[:page])
  end
end
