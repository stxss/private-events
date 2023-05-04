class Invitation < ApplicationRecord
  belongs_to :invitation_creator, foreign_key: "creator_id", class_name: "User"
  belongs_to :invited_event, class_name: "Event"
  belongs_to :invitee, foreign_key: "invitee_id", class_name: "User"
end
