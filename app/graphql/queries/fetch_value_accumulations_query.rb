module Queries
  class FetchValueAccumulationsQuery < BaseResolver
    type [Types::AccumulationType], null: false

    def resolve
      Accumulation.approved.current
    end
  end
end