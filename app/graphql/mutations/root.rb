module Mutations
  class Root < GraphQL::Schema::Object
    graphql_name 'Mutations'

    field :createUser, mutation: CreateUserMutation
    field :createAccumulation, mutation: CreateAccumulationMutation
  end
end