require 'securerandom'

module NixusSecurity
	module GUID
		SIZE = 32
		def self.generate()
			SecureRandom.uuid.gsub('-','').upcase
		end
	end

	module MD5
		SIZE = 32
		def self.generate(value)
			Digest::MD5.hexdigest value
		end
	end
	
	module RandomString
		def self.generate(size=16, valid_character_set=nil)
			if(valid_character_set.nil?)
				valid_character_set = ('0'..'9').to_a
				valid_character_set += ('a'..'z').to_a
				valid_character_set += ('A'..'Z').to_a
			end
			valid_character_set_size = valid_character_set.length
			result=""
			(1..size).each{
				result+=valid_character_set[SecureRandom.random_number(valid_character_set_size)]
			}
			result
		end
	end
end
