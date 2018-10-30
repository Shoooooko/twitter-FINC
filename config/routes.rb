# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  # For  on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    settings:      'users/settings', only: [:new, :create]
  }
  resources :users do
    resources :profiles, controller: "users/profiles"
  end


  resources :users do
    resources :settings, controller: "users/settings"
    #resources :profiles, controller: "users/profiles"
  end
  resources :follows

  get 'homes', to: 'homes#index'
  get 'homes/mypage', to: 'homes#mypage'
  post 'fav_post', to: 'fav_posts#create'
  post 'fav_comment', to: 'fav_comments#create'

  resources :posts do
    resources :comments, controller: 'posts/comments'
  end
end
