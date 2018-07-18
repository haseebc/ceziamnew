Rails.application.routes.draw do
  # match urls where the host starts with 'www.' as long it's not followed by 'cute.'
  constraints(host: /^www\.(?!cute\.)/i) do 

    match '(*any)', via: :all, to: redirect { |params, request|

      # parse the current request url
      # tap in and remove www. 
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s }
  end

  get 'dashboard/profile'
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
