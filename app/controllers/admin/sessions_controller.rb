class Admin::SessionsController < ApplicationController

  def new
    
  end

  def create
    
    if admin = Admin.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for admin
      redirect_to admin_root_path
    else
      redirect_to admin_sign_in_path, alert: "メールアドレスまたはパスワードが正しくありません"
    end
  end

  def destroy
    terminate_session
    redirect_to admin_sign_in_path
  end
end