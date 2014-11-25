require 'active_support/concern'
require 'nixus_api'
require 'nixus_validation'
require 'nixus_security'

module ApiAuthenticable
	extend ActiveSupport::Concern
	
	included do
		#validations
		validate :api_id_cannot_be_changed

	        validates :api_id,
	                presence: true,
	                format: { :with => /[A-Z0-9]{#{NixusAPI::ID_SIZE}}/, :message => :invalid, unless: 'api_id.blank?'},
	                uniqueness: { unless: 'api_id.blank?' }

		validates :api_secret_hash,
	                format: { :with => /[A-z0-9]{#{NixusSecurity::MD5::SIZE}}/, :message => :invalid, unless: 'api_secret_hash.blank?'}

		#callbacks
		after_initialize :set_api_id
	end	
	
	private
	def set_api_id()
		self.api_id ||= NixusAPI::generate_new_id()
	end
	
	def api_id_cannot_be_changed()
		return unless api_id_changed?
		errors.add :api_id, I18n.t('errors.messages.read_only', :attribute=>"api_id")
	end

	def update_api_secret_hash(api_secret)
		self.api_secret_hash = NixusSecurity::MD5.generate("#{@api_id}#{api_secret}")
        end

        def reset_api_secret()
                api_secret = NixusAPI::generate_new_secret()
                update_api_secret_hash(api_secret)
                api_secret
        end
end
