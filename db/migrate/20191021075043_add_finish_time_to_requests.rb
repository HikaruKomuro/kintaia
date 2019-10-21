class AddFinishTimeToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :finish_time, :datetime
  end
end
