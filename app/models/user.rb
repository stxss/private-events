class User < ApplicationRecord
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :created_events, foreign_key: "creator_id", class_name: "Event"

  has_many :event_attendances, foreign_key: :attendee_id
  has_many :attendances, through: :event_attendances, source: :attended_event

  has_many :event_invitations, foreign_key: :creator_id
  has_many :invitations_sent, through: :event_invitations, source: :invitation_creator

  has_many :event_invitations, foreign_key: :invitee_id
  has_many :invitations_received, through: :event_invitations, source: :invitee

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  # only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value",
        {value: login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
