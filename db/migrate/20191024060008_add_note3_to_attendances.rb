class AddNote3ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :note3, :string
  end
end
