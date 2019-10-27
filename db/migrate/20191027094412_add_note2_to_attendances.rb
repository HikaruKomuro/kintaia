class AddNote2ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :note2, :string
  end
end
