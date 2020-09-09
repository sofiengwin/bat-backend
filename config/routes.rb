require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  mount Sidekiq::Web => '/sidekiq'
end
