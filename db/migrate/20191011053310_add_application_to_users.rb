class AddApplicationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :application, :integer
  end
end
