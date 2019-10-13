class AddApplicantToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :applicant, :integer
  end
end
