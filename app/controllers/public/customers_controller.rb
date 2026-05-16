class Public::CustomersController < Public::ApplicationController
  def show
    @customer = current_customer
  end
end
