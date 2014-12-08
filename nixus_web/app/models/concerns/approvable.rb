require 'active_support/concern'

module Approvable
	extend ActiveSupport::Concern
	
	included do
		#associations
		has_one :approval, as: :approvable, dependent: :destroy

		#callbacks
                after_create :create_approval
                after_rollback :destroy_approval, on: :create

		#scopes
		scope :pending, -> {where(id: Approval.pending(self.name).pluck(:approvable_id))}
		scope :approved, -> {where(id: Approval.approved(self.name).pluck(:approvable_id))}
		scope :refused, -> {where(id: Approval.refused(self.name).pluck(:approvable_id))}
	end
	
	def approve
                self.approval.update(:status => NixusValidation::ApprovalStatuses::APPROVED)
        end

	def refuse
                self.approval.update(:status => NixusValidation::ApprovalStatuses::REFUSED)
        end

	def approved?
                self.approval.status == NixusValidation::ApprovalStatuses::APPROVED
        end

        def pending?
 	  self.approval.status == NixusValidation::ApprovalStatuses::PENDING
        end
        
	def refused?
 	  self.approval.status == NixusValidation::ApprovalStatuses::REFUSED
        end

        private

        def create_approval()
                app = Approval.new()
                app.approvable = self
                app.save!
        end

        def destroy_approval()
                return if self.approval.nil?
                self.approval.destroy
        end
end
