class EventAttendance < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :attended_event, class_name: "Event"

  validate :ok_date?

  private

  def ok_date?
    if attended_event.start_date < Date.current
      errors.add(:start_date, "can't be in the past")
    end
  end
end
