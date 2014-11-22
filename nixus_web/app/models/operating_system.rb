require 'nixus_validation'

class OperatingSystem < ActiveRecord::Base
	#validations
	validates :cpu_architecture,
		presence: true,
		inclusion: {:in => NixusValidation::ValidCpuArchitectures, :message => :inclusion, unless: 'cpu_architecture.blank?'},
		uniqueness: {:scope => :cpe_name}
	#TODO
	#Inlude cpe_name format validation
	validates :cpe_name,
		presence: true
	
	#scopes
	
	#associations
	has_many :client_applications
	
	#custom getters

	#custom setters
	def cpuArchitecture=(arch)
		write_attribute(:cpu_architecture, arch.downcase)
	end
	
	def cpeName=(name)
		write_attribute(:cpe_name, name.downcase)
	end
	
end
