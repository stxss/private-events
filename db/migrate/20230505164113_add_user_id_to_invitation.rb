class AddUserIdToInvitation < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :user_id, :integer
  end
end
