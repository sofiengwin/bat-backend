module Types
  class MatchType < BaseObject
    field :id, ID, null: false
    field :homeTeamName, String, null: false
    field :awayTeamName, String, null: false
    field :score, String, null: true
    field :league, String, null: false
    field :country, String, null: false
  end 
end