class Public::SessionsController < Public::ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    redirect_to root_path if authenticated_customer?
  end

  def create
    customer = Customer.authenticate_by(params.permit(:email, :password))
    if customer && customer.is_active
      start_new_session_for customer
      redirect_to customers_my_page_path
    else
      redirect_to customers_sign_in_path, alert: "メールアドレスまたはパスワードが正しくありません"
    end
  end

  def destroy
    terminate_session
    redirect_to customers_sign_in_path
  end

  private

  def customer_state
    customer = Customer.find_by(email: params[:email])
    return if customer.nil?
    return unless customer.authenticate(params[:password])
    unless customer.is_active
      redirect_to customers_sign_up_path
    end
  end
end