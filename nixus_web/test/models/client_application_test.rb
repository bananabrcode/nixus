require 'test_helper'
require 'nixus_validation'

class ClientApplicationTest < ActiveSupport::TestCase
	
	test "Approval status should be pending after commit" do
		client_app = ClientApplication.new()
		client_app.operating_system = operating_systems(:valid_x64)
		client_app.save
		assert client_app.pending?, "Approval status is not pending after initialization"
	end

	test "Approval status should change after approval for pending client" do
		client_app = client_applications(:pending_client)
		client_app.approve()
		assert client_app.approved?, "Approval status did not change after approval"
	end

	test "Dependent models should be destroyed" do
		ClientApplication.destroy_all
		assert_equal Approval.all.count,0,"Some approvals are still present even after destroying all clients"
		assert_equal ApiCredential.all.count,0,"Some API credentials are still present even after destroying all clients"
	end
end
