module Queries
  class ViewAccumulationQuery < BaseResolver
    argument :accumulationId, ID, required: true, prepare: ->(id, _) { Accumulation.find_by_id(id) }, as: :accumulation

    type Types::ViewAccumulationType, null: false

    def resolve(accumulation:)
      return GraphQL::ExecutionError.new("Something went wrong", extensions: { "accumulation" => "notFound" }) unless accumulation
  
      availableTips = Tip.where.not(id: accumulation.tips.map(&:id))

      {accumulation: accumulation, availableTips: availableTips}
    end
  end
end