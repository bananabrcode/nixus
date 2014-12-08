class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :type
      t.integer :status
      t.references :client_application, index: true

      t.timestamps
    end
    
    add_column :client_applications, :made_contact_at, :datetime
  end
end
