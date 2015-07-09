Rails.application.routes.draw do

  namespace :admin do
    root "dashboard#index"
    resources :categories
    resources :words
    resources :imports, only: [:create]
    resources :users
  end

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :categories, only: [:index]
  resources :words, only: [:index]
end
