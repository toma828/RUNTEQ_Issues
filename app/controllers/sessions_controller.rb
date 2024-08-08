class SessionsController < ApplicationController
  skip_before_action :require_login
  
  def new; end
  
  def create
    @user = login(params[:email], params[:password])
    if @user
      if @user.activation_state != 'active'
        flash[:alert] = 'メールアドレスが確認されていません。確認メールを再送信してください。'
        redirect_to action: :new
      else
        redirect_back_or_to top_path, notice: '魔法の書にログインしました！'
      end
    else
      flash[:alert] = '魔法の通信アドレスまたは秘密の呪文が間違っています。'
      redirect_to action: :new
    end
  end

  def destroy
    logout
    redirect_to top_path, notice: '魔法の書からログアウトしました。'
  end
end