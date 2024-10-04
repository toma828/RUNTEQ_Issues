# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root 'tops#index'
  root 'landing#index'
  get '/top', to: 'tops#index'
  get 'mypage', to: 'users#show'

  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider

  get '/terms', to: 'terms#terms'

  get 'liff', to: 'pages#liff'

  post '/line_webhook', to: 'line_bot#callback'
  post '/diaries/create_from_line', to: 'diaries#create_from_line'

  namespace :public do
    resources :contacts, only: %i[new create] do
      collection do
        post 'confirm'
        post 'back'
        get 'done'
      end
    end
  end

  resources :users do
    member do
      get :activate
    end
  end

  resource :session, only: %i[new create destroy]

  resources :diaries do
    member do
      get :waiting_for_response
      get :chatgpt_response
      get :check_response
    end
  end

  resources :password_resets, only: %i[new create edit update]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
