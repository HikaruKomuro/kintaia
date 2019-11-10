class AddWorkingToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :working, :integer, default: 0
  end
end
