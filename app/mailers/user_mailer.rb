class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(@user.activation_token)
    mail(to: user.email, subject: "魔法の書契約 - メール確認")
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "魔法の書契約 - 登録完了")
  end
end