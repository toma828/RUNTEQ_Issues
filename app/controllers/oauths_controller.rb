class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:denied].present?
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
      return
    end
    create_from(provider) unless (@user = login_from(provider))
    redirect_to root_path, notice: "#{provider.titleize}でログインしました"
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def create_from(provider)
    @user = build_from(provider)
    @user.line_login = true
    @user.email = "line_#{SecureRandom.hex(5)}@example.com"  # 仮のメールアドレス
    @user.password = SecureRandom.urlsafe_base64
    @user.password_confirmation = @user.password
    @user.activation_state = 'active'  # メール認証をスキップ
    @user.save!(validate: false)  # バリデーションをスキップ
    @user
  end
end