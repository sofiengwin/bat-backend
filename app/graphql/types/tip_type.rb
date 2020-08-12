module Types
  class TipType < BaseObject
    field :id, Int, null: false
    field :rating, String, null: true
    field :outcome, OutcomeType, null: false
    field :bet, String, null: false
    field :match, MatchType, null: false

    def outcome
      object.outcome.upcase
    end
  end 
end