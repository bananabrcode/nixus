require 'nixus_validation'

class ClientApplication < ActiveRecord::Base
	#INCLUSIONS & EXTENSIONS
	include ApiAuthenticable
	include Approvable
	include GenericScopes

	#associations:
	belongs_to :operating_system
	has_many :tasks

end

