class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :status
      t.references :approvable, polymorphic: true

      t.timestamps
    end

    change_table :client_applications do |t|
      t.remove :approval_status
    end
  end
end
