class AddSuperiorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :superior, :integer
  end
end
