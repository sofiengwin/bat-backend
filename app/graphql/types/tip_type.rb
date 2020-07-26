module Types
  class TipType < BaseObject
    field :rating, String, null: true
    field :outcome, String, null: false
    field :bet, String, null: false
    field :match, MatchType, null: false
  end 
end