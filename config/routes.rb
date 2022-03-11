Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  
  root to: 'quizzes#index'
  post 'sign_up', to: 'users#create'
  post 'login', to: 'authentication#create'

  resources :answered_questions, only: [:create, :update]
end
