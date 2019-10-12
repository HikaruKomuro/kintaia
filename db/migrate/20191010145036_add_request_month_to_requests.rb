class AddRequestMonthToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :request_month, :datetime
  end
end
