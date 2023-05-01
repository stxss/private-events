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

  private

  def require_login
    user_signed_in?
  end

  def event_params
    params.require(:event).permit(:title, :body)
  end
end
