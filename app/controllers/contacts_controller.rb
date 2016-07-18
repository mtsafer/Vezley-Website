class ContactsController < ApplicationController
  def new
  	@user = current_user
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new contact_params
  	if @contact.save
  		flash[:success] = "Message Sent"
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
