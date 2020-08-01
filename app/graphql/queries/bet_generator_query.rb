module Queries
  class BetGeneratorQuery < BaseResolver
    argument :minOdd, ID, required: false
    argument :maxOdd, ID, required: false

    type Types::ViewAccumulationType, null: false

    def resolve(accumulation:)
      availableTips = Tip.where.not(id: accumulation.tips.map(&:id))

      {accumulation: accumulation, availableTips: availableTips}
    end
  end
end