module Queries
  class Root < GraphQL::Schema::Object
    graphql_name 'Query'

    # field :fetchDriver, resolver: FetchDriverQuery
  end
end