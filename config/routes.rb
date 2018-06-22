Rails.application.routes.draw do
  get 'dashboard/checks' 
  get 'dashboard/detailed-results'
  
  devise_for :users
  root to: 'pages#home'

  resources :checks do
    resources :vulnerabilities, only: [:new, :create]
  end

  resources :users, only: [:edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
