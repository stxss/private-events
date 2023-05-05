class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @invitation = Invitation.new
  end

  def create
    @event_id = params[:invited_event_id]
    @creator_id = params[:creator_id]
    @invitation = current_user.invitations_sent.create(creator_id: @creator_id, invited_event_id: @event_id, invitee_id: invitation_params)

    if @invitation.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event_id = invitation_params[:invited_event_id]
    @invitation = Invitation.where(invited_event_id: @event_id, invitee_id: current_user).first

    if @invitation.destroy
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(invitee_id: [])
  end
end
