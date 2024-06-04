Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#index'

  resources :pages do
    collection do
      get :discover
      get :filter
    end
  end

  get '/search', to: 'pages#search'

  get '/check_username_availability', to: 'users#check_username_availability'

  get '/check_email_availability', to: 'users#check_email_availability'

  get '/check_email_exists', to: 'users#check_email_exists'

  get '/check_password_correct', to: 'users#check_password_correct'

  resources :users, only: %i[index show destroy] do
    member do
      get :settings
      get :purchases
      get :followings
      get :bookmarks
      get :user_reviews
      get :user_pledges
      patch :update_username
      patch :update_password
      patch :update_avatar
      delete :destroy_avatar
    end
    resources :creators do
      resources :followings, only: %i[index create destroy]
    end
    resources :avatars
    resources :socials
    member do
      get :videos, to: 'creators#videos'
      get :pledges, to: 'creators#pledges'
    end
  end
  resources :videos do
    member do
      get :video_reviews
    end
    resources :reviews
    resources :bookmarks, only: %i[index create destroy]
  end
  resources :categories, only: %i[index show create update destroy]
  resources :purchases, only: %i[index create new show destroy]
  resources :pledges, only: %i[index create new show destroy]
end
