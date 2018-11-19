# frozen_string_literal: true

Rails.application.routes.draw do
  #devise_for :admins
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # For  on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admins, controllers: {
    confirmations: 'admins/confirmations',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations',
    sessions:      'admins/sessions'
  }

   namespace :admins do
     resources :users ,only: [:index, :show]
   end

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
  
  resources :posts
  resources :follows, only: [:create, :destroy]
  resources :fav_posts, only: [:create, :destroy]
  resources :fav_comments, only: [:create, :destroy]
  get 'homes', to: 'homes#index'
  get 'homes/mypage', to: 'homes#mypage'

  resources :posts do
    resources :comments, controller: 'posts/comments'
  end
end
