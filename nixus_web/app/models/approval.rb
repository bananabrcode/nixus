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
	scope :unapproved, ->(type) { where("status = ? AND approvable_type = ?", NixusValidation::ApprovalStatuses::UNAPPROVED, type) }

	def initialize()
		super
		self.status ||= NixusValidation::ApprovalStatuses::PENDING
	end
	
	def approved?()
		self.status == NixusValidation::ApprovalStatuses::APPROVED
	end
	
	def unapproved?()
		self.status == NixusValidation::ApprovalStatuses::UNAPPROVED
	end
	
	def pending?()
		self.status == NixusValidation::ApprovalStatuses::PENDING
	end

end
