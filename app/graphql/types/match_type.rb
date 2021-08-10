module Types
  class MatchType < BaseObject
    field :id, ID, null: false
    field :homeTeamName, String, null: false, method: :home_team_name
    field :awayTeamName, String, null: false, method: :away_team_name
    field :score, String, null: true
    field :league, String, null: false
    field :country, String, null: false
  end 
end