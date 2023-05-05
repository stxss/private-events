class Invitation < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :invitee, class_name: "User"
  belongs_to :invited_event, class_name: "Event"

  attr_accessor :invitee_ids

  has_many :recipients, class_name: "User"
end
