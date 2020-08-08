module Queries
  class FetchTipsQuery < BaseResolver
    type [Types::TipType], null: false

    def resolve
      Tip.all
    end
  end
end