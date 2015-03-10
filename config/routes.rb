Rails.application.routes.draw do
  root  'static_pages#home'
  get   'subject_of_course' => 'subject_of_courses#show'
  get 'help'  =>  'static_pages#help'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :courses do
    resource :course_subject_relationships
    resource :training_progresses
    resources :subjects
  end

  resources :subjects
  resources :tasks
  resources :subjects
  resources :users
  resources :training_progresses
  resources :subject_progresses

  namespace :supervisor do
    resources :users
    resources :courses do
      resources :subjects
    end
    resources :subjects
    resources :tasks
  end
  get "*path" => 'static_pages#error'
end