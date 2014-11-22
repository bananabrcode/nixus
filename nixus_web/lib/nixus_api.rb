require 'nixus_security'

module NixusAPI
	ID_SIZE=32
	SECRET_SIZE=64

	def self.generate_new_id()
		NixusSecurity::GUID::generate()
	end

	def self.generate_new_secret()
		NixusSecurity::RandomString.generate(SECRET_SIZE)
	end
end
