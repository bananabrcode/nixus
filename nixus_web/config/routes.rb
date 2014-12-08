Rails.application.routes.draw do
  get 'approvals/update'

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

end
