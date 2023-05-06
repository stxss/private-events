class UpdateInvitations < ActiveRecord::Migration[7.0]
  def change
    rename_column :invitations, :invited_event_id, :event_id
    rename_column :invitations, :creator_id, :inviter_id
    remove_column :invitations, :user_id, :integer
  end
end
