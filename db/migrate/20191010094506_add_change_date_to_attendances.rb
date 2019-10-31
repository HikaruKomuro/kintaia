class AddChangeDateToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :change_date, :integer
  end
end
