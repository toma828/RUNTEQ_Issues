Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  #root "tops#index"
  root 'landing#index'
  get '/top', to: "tops#index"
  get 'mypage', to: 'users#show'

  resources :users do
    member do
      get :activate
    end
  end
  resource :session, only: [:new, :create, :destroy]
  resources :diaries do
    member do
      get :waiting_for_response
      get :chatgpt_response
      get :check_response
    end
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
