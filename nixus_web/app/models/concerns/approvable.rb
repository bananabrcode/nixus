require 'active_support/concern'

module Approvable
	extend ActiveSupport::Concern
	
	included do
		#associations
		has_one :approval, as: :approvable

		#callbacks
                after_save :create_approval, on: :create
                after_rollback :destroy_approval, on: :create

		#scopes
		scope :pending, -> {where(id: Approval.pending(self.name).pluck(:approvable_id))}
		scope :approved, -> {where(id: Approval.approved(self.name).pluck(:approvable_id))}
		scope :unapproved, -> {where(id: Approval.unapproved(self.name).pluck(:approvable_id))}
	end
	
	def approve()
                self.approval.status == NixusValidation::ApprovalStatuses::APPROVED
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
