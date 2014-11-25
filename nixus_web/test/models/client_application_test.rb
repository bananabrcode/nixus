require 'test_helper'
require 'nixus_api'
require 'nixus_validation'

class ClientApplicationTest < ActiveSupport::TestCase
	test "Should contain an API id after initialization" do
		client_app = ClientApplication.new()
		assert_not client_app.api_id.blank?, "Client Application API id is blank after initialization"
	end
	
	test "API id should be a valid GUID" do
		client_app = ClientApplication.new()
		assert client_app.api_id.length == NixusAPI::ID_SIZE, "Client Application API id does have a valid length"
		assert client_app.api_id =~ /[A-Z0-9]/, "Client Application API id have an invalid format"
	end
	
	test "Should not be able to alter the API id" do
		client_app = client_applications(:approved_client)
		client_app.api_id="0"*NixusAPI::ID_SIZE
		assert_not client_app.save, "Was able to modify API id"
	end
	
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
		assert_not client_app.api_secret_hash.blank?, "API secret hash was not set after approval"
	end
end
