require 'nixus_validation'

module ClientApplicationsHelper
	def get_readable_status(status)
		case status
			when NixusValidation::ApprovalStatuses::PENDING
				return content_tag(:span, t('misc.approval_statuses.pending'), :class => 'approval_status')
			when NixusValidation::ApprovalStatuses::APPROVED
				return content_tag(:span, t('misc.approval_statuses.approved'), :class => 'approval_status')
			when NixusValidation::ApprovalStatuses::REFUSED
				return content_tag(:span, t('misc.approval_statuses.refused'), :class => 'approval_status')
				
		end
	end
end
