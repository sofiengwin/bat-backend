module Queries
  class BetGeneratorQuery < BaseResolver
    argument :minOdd, Int, required: false
    argument :maxOdd, Int, required: false
    argument :totalOdds, Int, required: false

    type Types::ViewAccumulationType, null: false

    def resolve(**inputs)
      availableTips = Tip.where.not(id: accumulation.tips.map(&:id))

      {accumulation: accumulation, availableTips: availableTips}
    end
  end
end