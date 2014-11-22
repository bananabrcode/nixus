class CreateClientApplications < ActiveRecord::Migration
  def change
    create_table :client_applications do |t|
      t.string :apiGuid
      t.string :hostname
      t.datetime :infoUpdatedAt
      t.integer :approvalStatus

      t.timestamps
    end
    add_index :client_applications, :apiGuid
  end
end
