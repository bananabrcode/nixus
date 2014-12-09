require 'nixus_client_application_tasks'

class ClientApplicationTask < ActiveRecord::Base
	#validations
	validates :task_type,
		presence: true,
		inclusion: {
			:in => NixusClientApplicationTasks::Types.constants.map{|c| NixusClientApplicationTasks::Types.const_get(c.to_s)},
			:message => :inclusion,
			unless: 'task_type.blank?'
		}

	#associations
	belongs_to :client_application
end
