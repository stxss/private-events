class EventsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
        redirect_to root_path
    else
        render :new, status: :unprocessable_entity
    end
  end

  private

  def require_login
    user_signed_in?
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :start_time, :end_date, :end_time,
      :organizer, :atendees)
  end
end
