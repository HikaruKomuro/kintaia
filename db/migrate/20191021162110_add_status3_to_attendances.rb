class AddStatus3ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :status3, :integer
  end
end
