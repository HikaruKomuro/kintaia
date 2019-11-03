class AddChangeDateToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :change_date, :integer
  end
end
