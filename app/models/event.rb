class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :attendee, dependent: :destroy

  has_many :invitees, through: :invitations, foreign_key: :invited_event_id, class_name: "Invitation"

  scope :past, -> { where("start_date < ?", Date.current) }
  scope :upcoming, -> { where("start_date > ?", Date.current) }
  scope :public_visibility, -> { where("visibility = ?", "public") }
  scope :private_visibility, -> { where("visibility = ?", "private") }

  # def self.past
    # Event.where("start_date < ? ", Date.current)
  # end

  # def self.upcoming
    # Event.where("start_date > ? ", Date.current)
  # end
end
