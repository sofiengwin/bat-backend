module Queries
  class BetGeneratorQuery < BaseResolver
    argument :minOdd, Float, required: false
    argument :maxOdd, Float, required: false
    argument :totalOdds, Float, required: false

    type [Types::TipType], null: false

    def resolve(**inputs)
      BetGenerator.perform(
        min_odd: args[:minOdd],
        max_odd: args[:maxOdd],
        total_odd: args[:totalOdds],
      ).value
    end
  end
end