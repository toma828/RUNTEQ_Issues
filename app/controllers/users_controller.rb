# frozen_string_literal: true

# Userコントローラー
class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create activate]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # 通常のサインアップではline_loginをfalseに設定
    @user.line_login = false
    if @user.save
      redirect_to top_path, notice: '確認メールを送信しました。メールを確認して登録を完了してください。'
    else
      flash[:errors] = @user.errors.full_messages.join(', ')
      redirect_to action: :new
    end
  end

  def show
    @user = current_user
    @unlocked_parts = @user.unlocked_image_parts
  end

  def activate
    @user = User.load_from_activation_token(params[:id])
    if @user
      @user.activate!
      auto_login(@user)
      redirect_to top_path, notice: 'メールアドレスが確認され、魔法の書の主人として認められました！'
    else
      redirect_to top_path, alert: '無効なリンクです'
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to top_path, notice: 'ユーザーが削除されました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
