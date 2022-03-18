Rails.application.routes.draw do

  apipie
  mount ActionCable.server => '/cable'
  
  root to: 'quizzes#index'
  post 'sign_up', to: 'users#create'
  post 'login', to: 'authentication#create'
  get 'home', to: 'authentication#show'
  get 'result', to: 'users#show'

  resources :answered_questions, only: [:create, :update]
end
