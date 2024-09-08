class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    else
      begin
        @user = create_from(provider)
        reset_session # セッションをリセット
        auto_login(@user) # 明示的にログイン処理を行う
        redirect_to root_path, notice: "#{provider.titleize}でアカウントを作成しログインしました"
      rescue
        redirect_to root_path, alert: "#{provider.titleize}でのログインに失敗しました"
      end
    end
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