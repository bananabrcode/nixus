require 'nixus_validation'

class ClientApplication < ActiveRecord::Base
	#INCLUSIONS & EXTENSIONS
	include ApiAuthenticable
	include Approvable

	#CLASS MACROS
	#validations:
	validates :operating_system_id,
		presence: { message: :blank }
	#scopes:
	#callbacks:
	after_initialize :set_defaults
	#associations:
	belongs_to :operating_system

	#INSTANCE METHODS
        #methods:

        #TODO: Only the approve method should be able to set the api_secret_hash
        def approve()
		api_secret = nil
                unless approved?
			api_secret = reset_api_secret()
			self.approval_status = NixusValidation::ApprovalStatuses::APPROVED
		end
		api_secret
        end

	private
	def set_defaults
		@attributes["approval_status"] ||= NixusValidation::ApprovalStatuses::PENDING
	end
end

