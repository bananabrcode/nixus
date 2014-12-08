require 'nixus_validation'

class ClientApplication < ActiveRecord::Base
	#INCLUSIONS & EXTENSIONS
	include ApiAuthenticable
	include Approvable

	#validations:
	#validates :operating_system,
	#	presence: { message: :blank }

	#associations:
	belongs_to :operating_system

end

