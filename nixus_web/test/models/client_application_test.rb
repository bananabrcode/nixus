require 'test_helper'
require 'nixus_api'
require 'nixus_validation'

class ClientApplicationTest < ActiveSupport::TestCase
	
	test "Approval status should be pending after initialization" do
		client_app = ClientApplication.new()
		assert client_app.approval_status == NixusValidation::ApprovalStatuses::PENDING, "Approval status is not pending after initialization"
	end

	test "Should not be saved without an Operating System reference" do
		client_app = ClientApplication.new()
		assert_not client_app.save, "Was saved without an Operating System"
	end	

	test "Should be saved if valid" do
		client_app = client_applications(:valid_sample)
		assert client_app.save, "Was not saved even with valid attributes"
	end

	test "Approval status should change after approval for pending client" do
		client_app = client_applications(:pending_client)
		client_app.approve()
		assert client_app.approval_status == NixusValidation::ApprovalStatuses::APPROVED, "Approval status did not change after approval"
	end
	
	test "API secret hash should be set after approval" do
		client_app = client_applications(:pending_client)
		client_app.approve()
		assert_not client_app.api_credential.api_secret_hash.blank?, "API secret hash was not set after approval"
	end
end
