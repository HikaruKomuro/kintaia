class AddNote1ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :note1, :string
  end
end
