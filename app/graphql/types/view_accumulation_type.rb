module Types
  class MatchType < BaseObject
    field :id, ID, null: false
    field :tips, [AccumulationType], null: false
    field :availableGames, [TipType], null: false
  end 
end