module Api
	module V1
		class ApprovalsController < ApiController
			before_action :set_approval, only: [:show]

			def show
				if @api_client.approved?
					@secret = @api_client.api_credential.set_api_secret
				end
			end

			private 
			def set_approval
				@approval = @api_client.approval
			end
		end
	end
end
