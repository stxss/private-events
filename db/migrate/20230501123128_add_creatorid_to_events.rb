class AddCreatoridToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :creator_id, :integer, foreign_key: true
  end
end
