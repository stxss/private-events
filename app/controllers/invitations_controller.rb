class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @invitation = Invitation.new
    @creator = InvitationCreator.new
  end

  def create
    result = InvitationCreator.call(invitation_params)

    if result
      flash[:info] = "Invitations successful!"
      redirect_to root_path
    elsif result.failed?
      flash[:warning] = "Failed to send invitations to the following #{"user".pluralize(invites.failed.count)}, please try again."
      flash[:notice] = result.failed
    end
  end

  def destroy
    @event_id = invitation_params[:event_id]
    @invitation = Invitation.where(event_id: @event_id, invitee_id: current_user).first

    if @invitation.destroy
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(invitee_ids: []).merge(inviter_id: current_user.id, event_id: params[:event_id])
  end
end
