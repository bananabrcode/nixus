require 'nixus_validation'

class ApprovalsController < ApplicationController
  before_action :set_approval_by_client_application, only: [:approve_client_application, :refuse_client_application]

  def approve_client_application
    @approval.update_attribute(:status, NixusValidation::ApprovalStatuses::APPROVED)
    redirect_to client_applications_path
  end
  
  def refuse_client_application
    @approval.update_attribute(:status, NixusValidation::ApprovalStatuses::UNAPPROVED)
    redirect_to client_applications_path
  end

  private
  def set_approval_by_client_application
    @approval = Approval.all.where("approvable_id = ? AND approvable_type = ?",params[:client_application_id], ClientApplication.name).first
  end

end
