require 'nixus_client_application_tasks'

class Task < ActiveRecord::Base
	#INCLUSIONS & EXTENSIONS
	include GenericScopes

	#validations
	validates :task_type,
		presence: true,
		inclusion: {
			:in => NixusClientApplicationTasks::Types.constants.map{|c| NixusClientApplicationTasks::Types.const_get(c.to_s)},
			:message => :inclusion,
			unless: 'task_type.blank?'
		}

	validates :client_awareness,
		presence: true

	validates :parameters,
		presence: {
			unless: 'task_type.blank?'
		}

	#associations
	belongs_to :client_application

	#callbacks
	after_initialize :set_defaults
	
	#instance methods
	def take()
		if self.update_attribute(:client_awareness, true)
			{:type => self.task_type, :parameters => self.parameters}
		else
			nil
		end
	end
	def take!()
		if self.update_attribute!(:client_awareness, true)
			{:type => self.task_type, :parameters => self.parameters}
		else
			nil
		end
	end

	private
	def set_defaults()
		self.client_awareness ||= false
		self.parameters ||= "{}"
	end
end
