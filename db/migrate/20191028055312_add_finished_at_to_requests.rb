class AddFinishedAtToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :finished_at, :time
  end
end
