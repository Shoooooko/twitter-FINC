# frozen_string_literal: true

Rails.application.routes.draw do
  # For  on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admins, controllers: {
                        confirmations: "admins/confirmations",
                        passwords: "admins/passwords",
                        registrations: "admins/registrations",
                        sessions: "admins/sessions",
                      }
  namespace :admins do
    resources :users, only: %i[index show]
  end
  devise_for :users, controllers: {
                       confirmations: "users/confirmations",
                       passwords: "users/passwords",
                       registrations: "users/registrations",
                       sessions: "users/sessions",
                       settings: "users/settings"
                     }
  resources :users, only: [:index, :show]
  namespace :users do
    resource :profiles
    resource :settings
  end
  resources :posts
  resources :follows, only: %i[create destroy]
  resources :fav_posts, only: %i[create destroy]
  resources :fav_comments, only: %i[create destroy]
  resources :posts do
    resources :comments, controller: "posts/comments"
  end
  namespace :api do
    post "posts", to: "posts#create"
  end
end
