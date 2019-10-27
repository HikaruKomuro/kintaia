class AddFinishTimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :finish_time, :datetime
  end
end
