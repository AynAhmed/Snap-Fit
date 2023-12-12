# frozen_string_literal: true

Rails.application.routes.draw do
  get 'weight_logs/create'
  get 'new/create'
  get 'dashboard/index'
  devise_for :users
  get 'welcome/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'welcome#index'

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :meals
  resources :workouts

  resources :goals
  resources :weight_logs
  get '/goals/weight_logs_data', to: 'goals#weight_logs_data'
  
  # Defines the root path route ("/")
  # root "posts#index"
end
