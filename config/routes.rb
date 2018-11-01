# frozen_string_literal: true

Rails.application.routes.draw do
  #devise_for :admins, path: /users
  namespace :admin do
    resources :users
  end
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :posts
  # For  on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    settings:      'users/settings', only: [:new, :create]
  }
  #resources :users, only: [:index, :show] do
  resources :users do
    resources :profiles, controller: "users/profiles"
    resources :settings, controller: "users/settings"
    #resources :profiles, controller: "users/profiles"
  end

  resources :follows, only: [:create, :destroy]
  get 'homes', to: 'homes#index'
  get 'homes/mypage', to: 'homes#mypage'
  post 'fav_post', to: 'fav_posts#create'
  post 'fav_comment', to: 'fav_comments#create'

  resources :posts do
    resources :comments, controller: 'posts/comments'
  end
end
