Rails.application.routes.draw do
  get 'dashboard/checks'
  get 'pages/glossary'
  
  devise_for :users, controllers: { registrations: "registrations" }

  root to: 'pages#home'

  resources :checks do
    resources :vulnerabilities, only: [:new, :create]
    get 'full-report'
  end

  resources :users, only: [:edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
