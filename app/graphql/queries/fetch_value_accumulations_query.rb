module Queries
  class FetchValueAccumulationsQuery < BaseResolver
    type [Types::AccumulationType], null: false

    def resolve
      Accumulation.where.not(approved_at: nil)
    end
  end
end