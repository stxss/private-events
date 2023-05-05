class Invitation < ApplicationRecord
  belongs_to :invitation_creator, class_name: "User"
  belongs_to :invitee, class_name: "User"
  belongs_to :event
end
