class AddFirstStartedAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_started_at, :time
  end
end
