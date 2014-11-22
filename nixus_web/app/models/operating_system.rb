require 'nixus_validation_helper'

class OperatingSystem < ActiveRecord::Base
	#validations
	validates :cpuArchitecture,
		presence: true,
		inclusion: {:in => NixusValidationValues::CpuArchitectures, :message => :inclusion, unless: 'cpuArchitecture.blank?'},
		uniqueness: {:scope => :cpeName}
	#TODO
	#Inlude cpeName validations
	
	#scopes

	#custom getters

	#custom setters
	def cpuArchitecture=(arch)
		write_attribute(:cpuArchitecture, arch.downcase)
	end
	
	def cpeName=(name)
		write_attribute(:cpeName, name.downcase)
	end
end
