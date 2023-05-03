class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :attendee, dependent: :destroy

  scope :past, -> { where("start_date < ?", Date.current)}
  scope :upcoming, -> { where("start_date > ?", Date.current)}

  # def self.past
    # Event.where("start_date < ? ", Date.current)
  # end
#
  # def self.upcoming
    # Event.where("start_date > ? ", Date.current)
  # end
end
