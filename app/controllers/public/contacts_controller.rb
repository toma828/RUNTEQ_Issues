# frozen_string_literal: true

# 問い合わせ
module Public
  # Inquiry controller
  class ContactsController < ApplicationController
    skip_before_action :require_login

    def new
      @contact = Contact.new
    end

    def confirm
      @contact = Contact.new(contact_params)

      return handle_invalid_contact if @contact.invalid?

      # Further processing if valid
    end

    def back
      @contact = Contact.new(contact_params)
      render :new
    end

    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        ContactMailer.send_mail(@contact).deliver_now
        redirect_to done_public_contacts_path, notice: 'お問い合わせが送信されました。'
      else
        handle_invalid_contact
      end
    end

    def done
    end

    private

    def handle_invalid_contact
      flash.now[:alert] = @contact.errors.full_messages.join(', ')
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('flash-messages', partial: 'shared/flash_messages'),
            turbo_stream.update('contact_form', partial: 'form', locals: { contact: @contact })
          ]
        end
      end
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message)
    end
  end
end
