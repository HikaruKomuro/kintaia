class AddStatus2Attendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :status2, :integer
  end
end
