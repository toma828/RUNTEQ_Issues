class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      flash.now[:alert] = @contact.errors.full_messages.join(", ")
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
      flash.now[:alert] = @contact.errors.full_messages.join(", ")
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
  end

  def done
  end

    private

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message)
    end
end