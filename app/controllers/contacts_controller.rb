class ContactsController < ApplicationController
  def new
  	@user = current_user
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new contact_params
    @contact.user_id = current_user.id
  	if @contact.save
  		flash[:success] = "Message Sent"
      UserMailer.contact_vezley(@contact).deliver_now
  		redirect_to root_path
  	else
  		@user = current_user
  		render :new
  	end
  end

  private

  def contact_params
  	params.require(:contact).permit(:message)
  end
end
