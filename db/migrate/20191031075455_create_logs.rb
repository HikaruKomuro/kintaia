class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
