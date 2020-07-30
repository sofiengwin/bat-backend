module Queries
  class FetchRankingQuery < BaseResolver
    type [Types::RankType], null: false

    def resolve
      FetchRanking.perform().value
    end
  end
end