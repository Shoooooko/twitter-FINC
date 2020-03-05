Rails.application.routes.draw do
  # For  on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    mypage:        'users/:id'
  }
  resources :my_threads do
    resources :comments, controller: "my_threads/comments"
  end

end
