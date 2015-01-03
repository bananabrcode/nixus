require 'api_constraints'

Rails.application.routes.draw do
	root 'operating_systems#index'

	resources :operating_systems

	resources :client_applications do
		resource :approval, only: [:update] do
			member do
				get 'approve', to: 'approvals#approve_client_application'
				get 'refuse', to: 'approvals#refuse_client_application'
			end
		end
	end

	namespace :api, :defaults => {:format => 'json'} do
		scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
			resource :host, only: [:update]
			resource :approval, only: [:show]
			resource :api_credential, only: [:show]
			resources :tasks, only: [:index]
		end
	end

end
