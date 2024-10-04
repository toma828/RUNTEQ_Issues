# frozen_string_literal: true

# ApplicationMailer
class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:mail, :mail_address)
  layout 'mailer'
end
