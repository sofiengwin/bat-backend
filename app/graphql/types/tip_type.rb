module Types
  class TipType < BaseObject
    field :id, Int, null: false
    field :rating, String, null: true
    field :outcome, String, null: false
    field :bet, String, null: false
    field :bet_category, String, null: false
    association :match, MatchType, null: false
    field :odd, Float, null: false

    def outcome
      # object.outcome&.upcase
      "WON"
    end
  end
end
