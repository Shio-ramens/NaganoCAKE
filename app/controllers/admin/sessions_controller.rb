class Admin::SessionsController < ApplicationController

  def new
    # ログイン画面を表示するだけ
  end

  def create
    # 仲間と同じ方式でAdminモデルから検索
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