class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :creator_id, foreign_key: true
      t.integer :invited_event_id, foreign_key: true
      t.integer :invitee_id, foreign_key: true
      t.string :answer, default: "pending"

      t.timestamps
    end
  end
end
