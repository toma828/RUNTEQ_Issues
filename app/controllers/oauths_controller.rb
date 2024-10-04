# frozen_string_literal: true

# ラインログイン
class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    begin
      Rails.logger.info "Callback initiated for provider: #{provider}"
      Rails.logger.info "Auth params: #{auth_params.inspect}"

      @user_hash = sorcery_fetch_user_hash(provider)
      Rails.logger.info "User Hash: #{@user_hash.inspect}"

      if (@user = login_from(provider))
        Rails.logger.info "Existing user logged in: #{@user.inspect}"
      else
        Rails.logger.info 'Creating new user from provider'
        @user = create_from(provider)
        Rails.logger.info "New user created: #{@user.inspect}"
      end

      auto_login(@user)
      Rails.logger.info "User logged in: #{@user.inspect}"
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    rescue OAuth2::Error => e
      Rails.logger.error "OAuth2 Error: #{e.message}"
      Rails.logger.error "OAuth2 Error Full Details: #{e.inspect}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to root_path, alert: "#{provider.titleize}でのログインに失敗しました: #{e.message}"
    rescue StandardError => e
      Rails.logger.error "Login Error: #{e.message}"
      Rails.logger.error "Full Error Details: #{e.inspect}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to root_path, alert: "#{provider.titleize}でのログインに失敗しました"
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def create_from(provider)
    @user = build_from(provider)
    @user.authentications.build(uid: @user_hash[:uid], provider: provider)
    @user.save!
    @user
  end

  def build_from(provider)
    raise "Failed to fetch user info from #{provider}" if @user_hash.nil?
  
    Rails.logger.info "Building user from provider data: #{@user_hash.inspect}"
  
    password = SecureRandom.urlsafe_base64
    @user = user_class.new(
      name: @user_hash[:user_info]['displayName'],
      email: @user_hash[:user_info]['email'] || "line_#{SecureRandom.hex(5)}@linelogin.com",
      line_uid: @user_hash[:uid],
      password: password,
      password_confirmation: password
    )
    @user.line_login = true
    @user.activate!
    Rails.logger.info "Built user: #{@user.inspect}"
    @user
  end
end
