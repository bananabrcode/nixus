require 'nixus_validation'

class OperatingSystem < ActiveRecord::Base
	#validations
	validates :cpu_architecture,
		presence: true,
		inclusion: {
			:in => NixusValidation::ValidCpuArchitectures,
			:message => :inclusion,
			unless: 'cpu_architecture.blank?'
		},
		uniqueness: {:scope => :cpe_name}
	#TODO
	#Inlude cpe_name format validation
	validates :cpe_name,
		presence: true,
		format: {
			:with => /cpe\:2\.3\:o(\:((((([A-Z_a-z0-9]|(\\(\\|(\?|\*)|(\!|"|#|\$|%|&|'|\(|\)|\+|,|\.|\/|\:|;|\<|\=|\>|@|\[|\]|\^|`|\{|\||\}|~))))([A-Z_a-z0-9]|(\\(\\|(\?|\*)|((\!|"|#|\$|%|&|'|\(|\)|\+|,|\.|\/|\:|;|\<|\=|\>|@|\[|\]|\^|`|\{|\||\}|~)|\-))))*)|([A-Z_a-z0-9]|(\\(\\|(\?|\*)|((\!|"|#|\$|%|&|'|\(|\)|\+|,|\.|\/|\:|;|\<|\=|\>|@|\[|\]|\^|`|\{|\||\}|~)|\-)))){2,})|((\?+|\*)([A-Z_a-z0-9]|(\\(\\|(\?|\*)|((\!|"|#|\$|%|&|'|\(|\)|\+|,|\.|\/|\:|;|\<|\=|\>|@|\[|\]|\^|`|\{|\||\}|~)|\-))))*))(\?+|\*){,1})){10}/, 
			:message => :invalid,
			unless: 'cpe_name.blank?'
		}
	
	#scopes
	
	#associations
	has_many :client_applications, dependent: :restrict_with_error
	
	#custom getters

	#custom setters
	def cpu_architecture=(arch)
		write_attribute(:cpu_architecture, arch.downcase)
	end
end
