class InvitationWiper < ApplicationService
  def initialize(params)
    @host = params[:inviter_id]
    @event = params[:event_id]
    @invitees = params[:invitee_ids].reject(&:blank?)
  end

  def call
    @invitees.each do |person|
      Invitation.where(event_id: @event, inviter_id: @host, invitee_id: person).delete_all
    end
  end
end
