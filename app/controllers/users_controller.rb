class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.line_login = false  # 通常のサインアップではline_loginをfalseに設定
    if @user.save
      redirect_to root_path, notice: '確認メールを送信しました。メールを確認して登録を完了してください。'
    else
      redirect_to action: :new
      flash[:errors] = @user.errors.full_messages.join(", ")
    end
  end

  def show
    @user = current_user
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      auto_login(@user)
      redirect_to top_path, notice: 'メールアドレスが確認され、魔法の書の主人として認められました！'
    else
      redirect_to top_path, alert: '無効なリンクです'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end