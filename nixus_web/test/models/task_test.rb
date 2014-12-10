require 'test_helper'
require 'nixus_client_application_tasks'
require 'json'

class TaskTest < ActiveSupport::TestCase

	test "Awareness status should be false after initilization" do
		t = Task.new()
		assert_equal false, t.client_awareness, "Client awareness is not set to false after initialization"
	end

	test "After a take, the awareness level should be set to true and the task instructions should contain a valid pair of type and parameters" do
		t = Task.new(:task_type => NixusClientApplicationTasks::Types::UPDATE_HOST_INFO)
		t_inst = t.take()
		valid_task_types = NixusClientApplicationTasks::Types.constants.map{|c| NixusClientApplicationTasks::Types.const_get(c.to_s)}
		assert_equal true, t.client_awareness, "Client awareness was not set to true after taking the task"
		assert_not_nil t_inst[:type], "The task instructions did not contain a task type"
		assert_not_nil t_inst[:parameters], "The task instructions did not contain the task parameters"
		assert valid_task_types.include?(t_inst[:type]), "Task instructions contained an invalid task type"		
	end
	#TODO
	#Validate parameters content

end
