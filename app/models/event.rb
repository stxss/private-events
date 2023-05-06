class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :attendee, dependent: :destroy

  scope :past, -> { where("start_date < ?", Date.current) }
  scope :upcoming, -> { where("start_date > ?", Date.current) }

  def visible?(user)
    if user
      user_is_creator = (user.id == creator_id)
      priv_invited = (visibility == "private" && user.invitations_received.where(event_id: id).any?)
      priv_attending = (visibility == "private" && user.attendances.where(id: id).any?)

      visibility == "public" || user && (user_is_creator || priv_invited || priv_attending)
    else
      visibility == "public"
    end
  end

  # def self.past
  # Event.where("start_date < ? ", Date.current)
  # end

  # def self.upcoming
  # Event.where("start_date > ? ", Date.current)
  # end
end
