require 'nixus_validation_helper'
require 'securerandom'

class ClientApplication < ActiveRecord::Base
	#validations
	validates :apiGuid,
		presence: true,
		format: { :with => /[A-Z0-9]{32}/, :message => :invalid, unless: 'apiGuid.blank?'},
		uniqueness: {unless: 'apiGuid.blank?'}

	validates :approvalStatus,
		presence: true,
		inclusion: { :in => NixusValidationValues::ValidApprovalStatuses, :message => :inclusion, unless: 'approvalStatus.blank?' }

	#scopes
	scope :approved, -> { where(approvalStatus: ApprovalStatuses::APPROVED) }
	scope :pending, -> { where(approvalStatus: ApprovalStatuses::PENDING) }
	scope :unapproved, -> { where(approvalStatus: ApprovalStatuses::UNAPPROVED) }

	#callbacks
	after_initialize :set_defaults

	#custom getters

	#custom setters
	
	private
	#attributes

	#methods
	def set_defaults
		@attributes["approvalStatus"] ||= ApprovalStatuses::PENDING
		@attributes["apiGuid"] ||= SecureRandom.uuid.gsub('-','').upcase
	end
end
