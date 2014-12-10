class RenameClientApplicationTasksToTasks < ActiveRecord::Migration
  def change
	rename_table :client_application_tasks, :tasks
  end
end
