module Queries
  class Root < GraphQL::Schema::Object
    graphql_name 'Query'

    field :fetchTrending, resolver: FetchTrendingTipsQuery
    field :fetchOffers, resolver: FetchOffersQuery
    field :fetchBookmakers, resolver: FetchBookmakersQuery
    field :fetchRanking, resolver: FetchRankingQuery
  end
end