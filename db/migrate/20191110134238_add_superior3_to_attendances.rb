class AddSuperior3ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :superior3, :string
  end
end
