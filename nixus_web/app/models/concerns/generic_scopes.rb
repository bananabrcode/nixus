require 'active_support/concern'

module GenericScopes
	extend ActiveSupport::Concern
	
	included do
		scope :older_than, ->(n) {where("created_at <= :days_ago", :days_ago => Time.now - n.days)}
	end
end
