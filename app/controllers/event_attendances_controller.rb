class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @attendance = EventAttendance.new
  end

  def create
    @attendance = EventAttendance.new(event_attendance_params)

    if @attendance.save
      redirect_to root_path, alert: "You registered your attendance successfully"
    else
      redirect_to root_path, alert: "You can't attend past events or events where you weren't invited"
    end
  end

  def destroy
    @event_id = event_attendance_params[:attended_event_id]
    @attendance = EventAttendance.where(attended_event_id: @event_id, attendee_id: current_user).first

    if @attendance.destroy
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_attendance_params
    params.require(:attendance).permit(:attended_event_id, :attendee_id)
  end
end
