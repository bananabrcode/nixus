require 'nixus_api'
require 'nixus_security'

class ApiCredential < ActiveRecord::Base
	#INCLUSIONS & EXTENSIONS
	#CLASS MACROS
	#validations:
	validate :api_id_cannot_be_changed, on: :update
	validate :api_secret_hash_cannot_be_changed, on: :update
	validates :api_authenticable,
		presence: { message: :blank }
	validates :api_authenticable_id,
		uniqueness: { unless: 'api_authenticable.nil?' }	
	validates :api_id,
		presence: { message: :blank },
		length: { :is => NixusAPI::ID_SIZE, unless: 'api_id.blank?' },
                format: { :with => /[A-Z0-9]{#{NixusAPI::ID_SIZE}}/, :message => :invalid, unless: 'api_id.blank?'},
                uniqueness: { unless: 'api_id.blank?' },
		on: :create

        validates :api_secret_hash,
		length: { :is => NixusAPI::SECRET_HASH_SIZE, unless: 'api_secret_hash.blank?' }
	#scopes:
	#callbacks:
	#associations:
	belongs_to :api_authenticable, polymorphic: true
	#INSTANCE METHODS
        #methods:
        def initialize()
		super
		set_api_id()
	end

        def set_api_secret()
		return nil unless self.api_secret_hash.blank?
                api_secret = NixusAPI::generate_new_secret()
                self.api_secret_hash = NixusSecurity::MD5.generate("#{self.api_id}#{api_secret}")
                api_secret
        end

	def validate(id, secret)
		return false unless id == self.api_id
		self.api_secret_hash == NixusSecurity::MD5.generate("#{id}#{secret}")
	end

        private
        def set_api_id()
                self.api_id ||= NixusAPI::generate_new_id()
        end

        def api_id_cannot_be_changed()
                return unless api_id_changed?
                errors.add :api_id, I18n.t('errors.messages.read_only', :attribute=>"api_id")
        end
        
	def api_secret_hash_cannot_be_changed()
                return unless api_secret_hash_changed?
                errors.add :api_secret_hash, I18n.t('errors.messages.read_only', :attribute=>"api_secret_hash")
        end
end
