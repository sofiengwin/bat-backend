module Queries
  class FetchTipsQuery < BaseResolver
    argument :betType, String, required: false
    argument :country, String, required: false
    argument :maxOdd, Float, required: false
    argument :minOdd, Float, required: false
    argument :currentTips, [ID], required: false
    argument :matchId, ID, required: false


    type [Types::TipType], null: false

    def resolve(**args)
      FilterTips.perform(
        max_odd: args[:maxOdd],
        min_odd: args[:minOdd],
        bet_type: args[:betType],
        country: args[:country],
        current_tips: args[:currentTips],
        match_id: args[:matchId]
      ).value
    end
  end
end