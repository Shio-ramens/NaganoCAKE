class Admin::SessionsController < ApplicationController
  

  def new
  end

  def create
   
    admin = Admin.find_by(email_address: params[:email_address])

    
    if admin && admin.authenticate(params[:password])
      
      
      admin_session = admin.sessions.create!
      
      
      cookies.signed[:admin_session_id] = { value: admin_session.id, expires: 2.weeks.from_now, permanent: true }
      
      redirect_to admin_root_path, notice: "ログインに成功しました！"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    
    if admin_session_id = cookies.signed[:admin_session_id]
      Session.find_by(id: admin_session_id)&.destroy
    end
    
    cookies.delete(:admin_session_id)
    redirect_to admin_sign_in_path, notice: "ログアウトしました"
  end
end