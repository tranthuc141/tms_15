Rails.application.routes.draw do
  get 'subject_progresses/update'

  root  'static_pages#home'
  get 'help'  =>  'static_pages#help'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get "*path" => 'static_pages#error'

  resources :courses do
    resource :course_subject_relationships
    resource :training_progresses
  end

  resources :subjects
  resources :tasks
  resources :subjects
  resources :users
  resources :training_progresses
  resources :subject_progresses

  namespace :supervisor do
    resources :users
    resources :courses
    resources :subjects
    resources :tasks
  end
end