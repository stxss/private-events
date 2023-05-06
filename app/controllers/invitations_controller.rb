class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @invitation = Invitation.new
  end

  def create
    invitations = InvitationCreator.call(invitation_params)

    if invitations

      redirect_to root_path, notice: "Invitations successful!"
    end
  end

  def destroy
    invitations = InvitationWiper.call(invitation_params)

    if invitations
      redirect_to root_path, alert: "Cancelled the invitations successfully!"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(invitee_ids: []).merge(inviter_id: current_user.id, event_id: params[:event_id])
  end
end
