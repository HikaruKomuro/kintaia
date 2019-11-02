class AddFirstFinishedAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_finished_at, :time
  end
end
