Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  root 'users#index'
  post 'users/add_random_users' => 'users#add_random_users'

end
