module Api
  module V1
    class HostsController < ApiController
      before_action :check_approval, only: [:update]

      def update
				params = operating_system_safe_params
				if @api_client.update(params)
					render :show
				else
					render json: @api_client.errors
				end
      end

      private
      def operating_system_safe_params
        params.require(:host).permit(:hostname, :cpu_architecture, :operating_system)
      end
    end
  end
end
