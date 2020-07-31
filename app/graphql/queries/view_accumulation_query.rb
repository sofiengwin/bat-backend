module Queries
  class ViewAccumulationQuery < BaseResolver
    argument :accumulationId, ID, required: true, prepare: ->(id, _) { Accumulation.find(id) }, as: :accumulation

    type Types::ViewAccumulationType, null: false

    def resolve(accumulation:)
      availableTips = Tip.where.not(id: accumulation.tips.map(&:id))

      {accumulation: accumulation, availableTips: availableTips}
    end
  end
end