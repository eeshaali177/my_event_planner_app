Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index'

 
  resources :events do
    resources :invitations, only: [:new, :create] 
    resources :comments
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :notifications do
    member do
     
      post :accept_invitation
      post :reject_invitation
    end
  end
  
  
  # Defines the root path route ("/")
  # root "posts#index"
  
 
  root to: "dashboard#index"

end
