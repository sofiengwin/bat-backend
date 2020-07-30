module Queries
  class FetchValueAccumulationsQuery < BaseResolver
    type [Types::AccumulationType], null: false

    def resolve
      Accumulation.joins(:tips).where.not(approved_at: nil)
    end
  end
end