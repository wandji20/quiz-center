require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end
  
  post "/graphql", to: "graphql#execute"

  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

  mount Sidekiq::Web => "/sidekiq"

  apipie
  mount ActionCable.server => '/cable'
  
  root to: 'quizzes#index'
  post 'sign_up', to: 'users#create'
  post 'login', to: 'authentication#create'
  get 'result', to: 'users#show'

  resources :answered_questions, only: [:create, :update]
end
