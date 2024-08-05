class SessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, notice: '魔法の書にログインしました！'
    else
      flash.now[:alert] = '魔法の通信アドレスまたは秘密の呪文が間違っています。'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: '魔法の書からログアウトしました。'
  end
end