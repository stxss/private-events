class UpdateEventDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :organizer, :string
    rename_column :events, :body, :description
    rename_column :events, :date, :start_date
    rename_column :events, :time, :start_time
    add_column :events, :end_date, :date
    add_column :events, :end_time, :time
  end
end
