class AddParametersToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :parameters, :string
  end
end
