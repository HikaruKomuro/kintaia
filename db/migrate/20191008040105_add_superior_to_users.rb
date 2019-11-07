class AddSuperiorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :superior, :integer, default: 1
  end
end
