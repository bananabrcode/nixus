class RenameColumnOnClientApplications < ActiveRecord::Migration
  def change
	rename_column :client_applications, :api_guid, :api_id
  end
end
