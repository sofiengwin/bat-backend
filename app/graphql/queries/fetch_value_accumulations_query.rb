module Queries
  class FetchValueAccumulationsQuery < BaseResolver
    type [Types::AccumulationType], null: false

    def resolve
      Accumulation.where.not(approved_at: nil).order(approved_at: :desc).limit(10)
    end
  end
end