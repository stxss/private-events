class InvitationCreator < ApplicationService
  def initialize(params)
    @host = params[:inviter_id]
    @event = params[:event_id]
    @invitees = params[:invitee_ids].reject(&:blank?)
    @log = {success: [], failed: []}
  end

  def call
    @invitees.each do |person|
      invitation = Invitation.new(event_id: @event, inviter_id: @host, invitee_id: person)
      unless invitation.save
        @log[:failed] << User.find(person.id)
      end
    end
  end
end
