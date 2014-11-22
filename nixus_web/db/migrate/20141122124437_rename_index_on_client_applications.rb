class RenameIndexOnClientApplications < ActiveRecord::Migration
  def change
	rename_index :client_applications, :OperatingSystem, :operating_system
  end
end
