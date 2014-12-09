class RemoveStatusFromTasks < ActiveRecord::Migration
  def change
	remove_column :tasks, :status
  end
end
