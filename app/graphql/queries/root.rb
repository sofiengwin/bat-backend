module Queries
  class Root < GraphQL::Schema::Object
    graphql_name 'Query'

    field :fetchTrending, resolver: FetchTrendingTipsQuery
  end
end