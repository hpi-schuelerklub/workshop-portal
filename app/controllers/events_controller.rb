class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.draft_is false
  end

  # GET /events/1
  def show
    @free_places = @event.compute_free_places
    @occupied_places = @event.compute_occupied_places
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    puts event_params.inspect
    @event = Event.new(event_params)

    @event.draft = (params[:draft] != nil)

    if @event.save
      redirect_to @event, notice: 'Event wurde erstellt.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    attrs = event_params

    @event.draft = (params[:commit] == "draft")

    if @event.update(attrs)
      redirect_to @event, notice: 'Event wurde aktualisiert.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event wurde gelöscht.'
  end

  # GET /events/1/participants
  def participants
    @event = Event.find(params[:id])
    @participants = @event.participants_by_agreement_letter
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:name, :description, :max_participants, :active, :kind, :organizer, :knowledge_level, date_ranges_attributes: [:start_date, :end_date, :id])
    end
end
