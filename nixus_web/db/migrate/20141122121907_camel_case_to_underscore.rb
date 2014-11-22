class CamelCaseToUnderscore < ActiveRecord::Migration
  def change
	#OperatingSystems
	rename_column :operating_systems, :displayName, :display_name
	rename_column :operating_systems, :cpeName, :cpe_name
	rename_column :operating_systems, :cpuArchitecture, :cpu_architecture
	
	#ClientApplications
	rename_column :client_applications, :apiGuid, :api_guid
	rename_column :client_applications, :infoUpdatedAt, :info_updated_at
	rename_column :client_applications, :approvalStatus, :approval_status
	rename_index :client_applications, :apiGuid, :api_guid
  end
end
