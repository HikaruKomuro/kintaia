class AddStartedAtToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :started_at, :time
  end
end
