class AddClientAwarenessToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :client_awareness, :boolean
  end
end
