Rails.application.routes.draw do
  
  # www to non-www redirect
  constraints(host: /^www\./i) do 
    match '(*any)' => redirect { |params, request| 
    URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s }, via: [:get, :post] 
  end

  get 'dashboard/profile'
  get 'pages/glossary'
  get 'pages/healthcheck'

  devise_for :users, controllers: { registrations: "registrations" }

  root to: 'pages#home'

  resources :checks do
    resources :vulnerabilities, only: [:new, :create]
    get 'full-report'
  end

  resources :users, only: [:edit, :update]

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
