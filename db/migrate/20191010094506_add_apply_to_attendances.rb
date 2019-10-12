class AddApplyToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :apply, :date
  end
end
