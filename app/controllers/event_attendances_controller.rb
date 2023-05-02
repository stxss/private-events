class EventAttendancesController < ApplicationController

    def new
        @attendance = EventAttendance.new

    end

    def create
        @attendance = EventAttendance.find_or_create_by(event_attendance_params)

        if @attendance.save
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
