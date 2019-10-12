class AddStatusToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :status, :integer
  end
end
