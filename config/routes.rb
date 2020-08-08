Rails.application.routes.draw do
root to: 'pages#top'
  devise_for :users
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
  get '/home/about' => 'pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end