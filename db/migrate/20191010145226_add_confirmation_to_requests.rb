class AddConfirmationToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :confirmation, :boolean
  end
end
