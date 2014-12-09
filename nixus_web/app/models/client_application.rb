require 'nixus_validation'

class ClientApplication < ActiveRecord::Base
	#INCLUSIONS & EXTENSIONS
	include ApiAuthenticable
	include Approvable

	#associations:
	belongs_to :operating_system
	has_many :client_application_tasks
end

