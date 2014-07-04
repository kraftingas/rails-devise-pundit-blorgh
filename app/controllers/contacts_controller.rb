class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.newest(current_user.id)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    Contact.counter(@contact)
  end

  # GET /contacts/new
  def new
    @user = User.find(params[:user_id])
    @contact = @user.contacts.new
    #@user_id = User.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @user = User.find(params[:user_id])
    @contact = @user.contacts.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @user, notice: 'Letter was successfully sent.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:user_id, :name, :email, :content, :shown_count)
    end
end
