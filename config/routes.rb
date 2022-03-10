Rails.application.routes.draw do
  get 'answered_questions/create'
  get 'answered_questions/update'
  post 'sign_up', to: 'users#create'
  post 'login', to: 'authentication#create'
end
