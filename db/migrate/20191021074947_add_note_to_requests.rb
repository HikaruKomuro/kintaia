class AddNoteToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :note, :string
  end
end
