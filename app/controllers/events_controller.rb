class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit]
  before_action :authenticate_user!
  # GET /events or /events.json
  def index
    
      @events = current_user.events
      @other_users_events = Event.where.not(user_id: current_user.id)
      @event_creators_emails = User.where(id: @other_users_events.pluck(:user_id)).pluck(:email) # Fetching emails of event creators
      @notifications = Noticed::Notification.where(recipient_id: current_user.id, recipient_type: "User")

  p @event_creators_emails
  end

  
  def show
    @event = Event.find(params[:id])
    @invitation = @event.invitations
    @comment= Comment.new
  end

 
  def new
    @event = Event.new
    @invitation = Invitation.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    # Ensure current user is the creator of the event
    if current_user != @event.user
      flash[:alert] = "You are not authorized to edit this event."
      redirect_to events_path
    end
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if current_user != @event.user
        format.html { redirect_to events_url, alert: "You are not authorized to update this event." }
        format.json { render json: { error: "You are not authorized to update this event." }, status: :unauthorized }
      elsif @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /events/1 or /events/1.json
  def destroy
    @event = Event.find_by(id: params[:id])
    if @event.nil?
      respond_to do |format|
        format.html { redirect_to events_url, alert: "Event not found." }
        format.json { render json: { error: "Event not found." }, status: :not_found }
      end
    elsif current_user != @event.user
      respond_to do |format|
        format.html { redirect_to events_url, alert: "You are not authorized to delete this event." }
        format.json { render json: { error: "You are not authorized to delete this event." }, status: :unauthorized }
      end
    else
      @event.destroy!
      respond_to do |format|
        format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end
  
  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :location)
  end
end
