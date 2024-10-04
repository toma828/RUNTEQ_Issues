# frozen_string_literal: true

# 認証用メールを送信するクラス
class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(@user.activation_token)
    mail(to: user.email, subject: '魔法の書契約 - メール確認')
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: '魔法の書契約 - 登録完了')
  end

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: '魔法の書契約 - パスワード再設定')
  end
end
