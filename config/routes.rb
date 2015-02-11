Rails.application.routes.draw do
  root   'static_pages#home'
  get    'sessions/new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'help'  =>  'static_pages#help'
  resources :courses
  resources :users
  namespace :supervisor do
    resources :users
  end
end
