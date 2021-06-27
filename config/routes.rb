require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post "/graphql", to: "graphql#execute"
  get "/consume", to: "graphql#consume"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  mount Sidekiq::Web => '/sidekiq'
end
