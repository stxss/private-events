class InvitationCreator < ApplicationService
    def initialize(params)
        @host = params[:creator_id]
        @event = params[:event_id]
        @invitees = params[:invitee_ids].reject(&:blank?)
        @results = { success: [], failure: []}
    end

    def call
        @invitees.each do |person|
            invitation = Invitation.new(invited_event_id: @event, creator_id: @host, invitee_id: person)
            if invitation.save
                @results[:success] << invitation
            else
                @results[:failure] << invitation
            end
        end
        OpenStruct.new(successes: @results[:success], failures: @results[:failure])
    end
end

