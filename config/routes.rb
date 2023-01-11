require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post "/graphql", to: "graphql#execute"
  get "/consume", to: "graphql#consume"
  root to: "graphql#health"

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  mount Sidekiq::Web => '/sidekiq'
end
