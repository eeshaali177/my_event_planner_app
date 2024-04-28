class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

def index
  @invitations = Invitation.where(sender_id: current_user.id)
  end
  
  #GET /invitations/1 or /invitations/1.json
  def show
  end
  
 # GET /invitations/new
  def new
  @invitation = Invitation.new
  @invitation.sender_id = current_user.id
  @invitation.event_id = params[:event_id] # Assuming you're passing the event_id in the URL
  end
  
  #GET /invitations/1/edit
  def edit
  end
  
  #POST /invitations or /invitations.json
  def create
    @event = Event.find(params[:event_id])
    recipient_email = invitation_params[:recipient_email]
    recipient_user = User.find_by(email: recipient_email)
  
    if recipient_user
      @invitation = @event.invitations.new(invitation_params)
      @invitation.sender_id = current_user.id
      respond_to do |format|
        if @invitation.save
          format.html { redirect_to @event, notice: "Invitation was successfully created." }
          format.json { render :show, status: :created, location: @invitation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @invitation.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = "Invitation could not be sent. Recipient email not found in our records."
      redirect_to @event
    end
  end
  #PATCH/PUT /invitations/1 or /invitations/1.json
  def update
  respond_to do |format|
  if @invitation.update(invitation_params)
  format.html { redirect_to invitation_url(@invitation), notice: "Invitation was successfully updated." }
  format.json { render :show, status: :ok, location: @invitation }
  else
  format.html { render :edit, status: :unprocessable_entity }
  format.json { render json: @invitation.errors, status: :unprocessable_entity }
  end
  end
  end
  
 # DELETE /invitations/1 or /invitations/1.json
  def destroy
  @invitation.destroy!
  respond_to do |format|
  format.html { redirect_to invitations_url, notice: "Invitation was successfully destroyed." }
  format.json { head :no_content }
  end
end
  
  private
  
  #Use callbacks to share common setup or constraints between actions.
  def set_invitation
  @invitation = Invitation.find(params[:id])
  end
  
  #Only allow a list of trusted parameters through.
  def invitation_params
  params.require(:invitation).permit(:sender_id, :recipient_email, :event_id)
  end
end
