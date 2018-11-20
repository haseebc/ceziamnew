Rails.application.routes.draw do

  # www to non-www redirect
  constraints(host: /^www\./i) do
    match '(*any)' => redirect { |_params, request|
                        URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
                      }, via: %i[get post]
  end

  get 'dashboard/profile'
  get 'glossary', to: 'pages#glossary'
  get 'healthcheck', to: 'pages#healthcheck'
  get 'privacy', to: 'pages#privacy'
  get 'blog', to: 'articles#index'
  get 'about', to: 'pages#about'

  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'pages#home'

  resources :checks do
    resources :vulnerabilities, only: %i[new create]
    get 'full-report'
  end

  resources :users, only: %i[edit update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles

end
