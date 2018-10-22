Rails.application.routes.draw do
  root to:'home#index'
  resources :posts
  
  # For  on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }
  get 'home', to: 'home#index'
  get 'home/mypage', to: 'home#mypage'
end
