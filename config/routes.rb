Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'users#index'
  post 'users/search' => 'users#search_users'
  post 'users/add_random_users' => 'users#add_random_users'

end
