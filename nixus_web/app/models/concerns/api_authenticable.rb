require 'active_support/concern'

module ApiAuthenticable
	extend ActiveSupport::Concern
	
	included do
		#associations
		has_one :api_credential, as: :api_authenticable

		#callbacks
		after_save :create_api_credential, on: :create
		after_rollback :destroy_api_credential, on: :create
	end
	
	def authenticate(id, secret)
		return false unless self.api_id == id
		self.api_credential.validate(id, secret)
	end
	
	private
	
	def create_api_credential()
		api_cred = ApiCredential.new()
		api_cred.api_authenticable = self
		api_cred.save!
	end

	def destroy_api_credential()
		return if self.api_credential.nil?
		self.api_credential.destroy
	end
end
