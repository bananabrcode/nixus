class ClientApplicationsController < ApplicationController
        before_action :set_client_application, only: [:edit, :update, :destroy]

        def index
                @client_applications = ClientApplication.all
        end

        def new
                @client_application = ClientApplication.new()
        end

        def edit
        end

        def create
                params = client_application_safe_params
                @client_application = ClientApplication.new(params)
                if @client_application.save
                        redirect_to client_applications_path, :notice => t('.success')
                else
                        @client_application.errors.add(:base, params.inspect) unless Rails.env.production?
                        @client_application.errors.add(:base, @client_application.inspect) unless Rails.env.production?
                        render action: 'new'
                end
        end

        def update
                params = client_application_safe_params
                if @client_application.update(params)
                        redirect_to client_applications_path, :notice => t('.success')
                else
                        @client_application.errors.add(:base, params.inspect) unless Rails.env.production?
                        @client_application.errors.add(:base, @client_application.inspect) unless Rails.env.production?
                        render action: 'edit'
                end
        end

        def destroy
                @client_application.destroy
                redirect_to client_applications_path, :notice => t('.success')
        end

        private
        def set_client_application
                @client_application = ClientApplication.find_by_id(params[:id])
        end

        def client_application_safe_params
                params.require(:client_application).permit(:hostname)
        end
end
