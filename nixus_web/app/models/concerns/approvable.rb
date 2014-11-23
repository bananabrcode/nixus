require 'active_support/concern'
require 'nixus_api'
require 'nixus_validation'
require 'nixus_security'

module Approvable
	extend ActiveSupport::Concern
	
	included do
		#validations
		validates :operating_system_id,
			presence: true
		validates :approval_status,
                	presence: true,
	                inclusion: { :in => NixusValidation::ValidApprovalStatuses, :message => :inclusion, unless: 'approval_status.blank?' }
		#scopes:
	        scope :approved, -> { where(approvalStatus: NixusValidation::ApprovalStatuses::APPROVED) }
	        scope :pending, -> { where(approvalStatus: NixusValidation::ApprovalStatuses::PENDING) }
	        scope :unapproved, -> { where(approvalStatus: NixusValidation::ApprovalStatuses::UNAPPROVED) }
	end

        #INSTANCE METHODS
	#methods:
	def approved?()
                self.approval_status == NixusValidation::ApprovalStatuses::APPROVED
        end
end
