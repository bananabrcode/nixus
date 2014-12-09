require 'nixus_client_application_tasks'

namespace :nixus do
  namespace :tasks do

    desc "Register an UPDATE_HOST_INFO task for all managed hosts"
    task(:reg_all_update_host_info => :environment) do
      for ca in ClientApplication.approved
        if ca.client_application_tasks.build(:task_type => NixusClientApplicationTasks::Types::UPDATE_HOST_INFO).save
          puts "Registered UPDATE_HOST_INFO task for #{ca.hostname}"
	else
          puts "Failed to register UPDATE_HOST_INFO task for #{ca.hostname}"
	end
      end
    end

  end
end
