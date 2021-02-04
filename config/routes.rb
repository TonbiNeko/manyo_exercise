Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'
  resources :users, only: [:index, :new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
