module Queries
  class FetchTrendingTipsQuery < BaseResolver
    type [Types::TrendType], null: false

    def resolve
      FetchTrendingTips.perform().value
    end
  end
end