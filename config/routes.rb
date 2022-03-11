Rails.application.routes.draw do
  post 'sign_up', to: 'users#create'
  post 'login', to: 'authentication#create'

  resources :answered_questions, only: [:create, :update]
end
