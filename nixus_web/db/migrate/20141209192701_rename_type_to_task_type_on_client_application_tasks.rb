class RenameTypeToTaskTypeOnClientApplicationTasks < ActiveRecord::Migration
  def change
	rename_column :client_application_tasks, :type, :task_type
  end
end
