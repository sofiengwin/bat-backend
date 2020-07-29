module Types
  class TrendType < BaseObject
    field :homeTeamName, String, null: false
    field :awayTeamName, String, null: false
    field :league, String, null: false
    field :country, String, null: false
    field :tipCount, Integer, null: false 
  end 
end