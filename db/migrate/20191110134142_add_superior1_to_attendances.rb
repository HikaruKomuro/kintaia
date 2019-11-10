class AddSuperior1ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :superior1, :string
  end
end
