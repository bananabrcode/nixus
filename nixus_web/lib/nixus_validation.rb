require 'nixus_api'
require 'nixus_security'

module NixusValidation
	module ApprovalStatuses
		APPROVED=1
		PENDING=0
		UNAPPROVED=-1
	end
	
	module CpuArchitectures
		X86='x86'
		X64='x64'
	end

	ValidCpuArchitectures = [CpuArchitectures::X86, CpuArchitectures::X64]
	ValidApprovalStatuses = [ApprovalStatuses::APPROVED, ApprovalStatuses::PENDING, ApprovalStatuses::UNAPPROVED]
end
