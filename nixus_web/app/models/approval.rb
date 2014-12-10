require 'nixus_validation'

class Approval < ActiveRecord::Base
	#associations:
	belongs_to :approvable, polymorphic: true

	#validations:
	validates :status,
		presence: true,
		inclusion: { :in => NixusValidation::ValidApprovalStatuses, :message => :inclusion, unless: 'status.blank?' }

	#scopes:
	scope :approved, ->(type) { where("status = ? AND approvable_type = ?", NixusValidation::ApprovalStatuses::APPROVED, type) }
	scope :pending, ->(type) { where("status = ? AND approvable_type = ?", NixusValidation::ApprovalStatuses::PENDING, type) }
	scope :refused, ->(type) { where("status = ? AND approvable_type = ?", NixusValidation::ApprovalStatuses::REFUSED, type) }

	#callbacks
	after_initialize :set_defaults

	def approved?()
		self.status == NixusValidation::ApprovalStatuses::APPROVED
	end
	
	def refused?()
		self.status == NixusValidation::ApprovalStatuses::REFUSED
	end
	
	def pending?()
		self.status == NixusValidation::ApprovalStatuses::PENDING
	end

	private
	def set_defaults()
		self.status ||= NixusValidation::ApprovalStatuses::PENDING
	end
end
