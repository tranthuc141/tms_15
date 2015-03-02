Rails.application.routes.draw do
  root  'static_pages#home'
  get 'help'  =>  'static_pages#help'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'signup' => 'users#new'
  resources :subjects do
    get "addtask"
  end
  resources :courses do
    resource :course_subject_relationships
    resource :training_progresses
  end
  resources :tasks
  resources :subjects
  resources :users
end
