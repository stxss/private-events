class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :attendee, dependent: :destroy

  scope :past, -> { where("start_date < ?", Date.current) }
  scope :upcoming, -> { where("start_date > ?", Date.current) }
  scope :public_visibility, -> { where("visibility = ?", "public") }
  scope :private_visibility, -> { where("visibility = ?", "private") }

  def visible?(user)
    visibility == "public" || (user && user.id == creator_id) || (visibility == "private" && user && !user.invitations_received.empty? && user.invitations_received.where(event_id: id).any?)
  end

  # def self.past
  # Event.where("start_date < ? ", Date.current)
  # end

  # def self.upcoming
  # Event.where("start_date > ? ", Date.current)
  # end
end
