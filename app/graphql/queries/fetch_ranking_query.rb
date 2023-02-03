module Queries
  class FetchRankingQuery < BaseResolver
    class FetchRankingType < Types::BaseObject
      field :weekly, [Types::RankType], null: false, hash_key: :weekly
      field :monthly, [Types::RankType], null: false, hash_key: :monthly
      field :total, [Types::RankType], null: false, hash_key: :total
    end

    type FetchRankingType, null: false

    def resolve
      FetchRanking.perform().value
    end
  end
end
