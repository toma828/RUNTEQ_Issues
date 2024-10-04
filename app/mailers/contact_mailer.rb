# frozen_string_literal: true

# 問い合わせメール
class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: Rails.application.credentials.dig(:mail, :mail_address), subject: "【お問い合わせ】#{@contact.subject}"
  end
end
