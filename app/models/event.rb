class Event < ApplicationRecord
  validate :ok_date?, on: %i[create new edit update]

  validates :title, presence: true, length: { in: 6..20 }
  validates :description, presence: true, length: { in: 20..500 }


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

  private

  def ok_date?
    if start_date < Time.current
      errors.add(:start_date, "can't be in the past")
    end

    if end_date < start_date
      errors.add(:start_date, "can't end before start")
    elsif end_date == start_date
      if end_time < start_time
        errors.add(:start_date, "can't end before start")
      end
    end
  end
  # def self.past
  # Event.where("start_date < ? ", Date.current)
  # end

  # def self.upcoming
  # Event.where("start_date > ? ", Date.current)
  # end
end
