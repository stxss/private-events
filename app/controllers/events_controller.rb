class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]


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
      flash.now[:alert] = "Oops, something went wrong, check your fields again"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
    @inviteable = User.order(:username).reject { |n| n == current_user || n.invitations_received.where(event_id: @event.id).any?}
    @cancellable = User.order(:username).where(id: Invitation.where(event_id: @event.id).pluck(:invitee_id))
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to root_path
    else
      flash.now[:alert] = "Oops, something went wrong, check your fields again"
      render :edit, status: :unprocessable_entity
    end
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
      :organizer, :atendees, :visibility)
  end
end
