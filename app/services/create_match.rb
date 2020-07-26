class CreateMatch < Service::Create
  field :home_team_name, presence: true
  field :away_team_name, presence: true
  field :fixture_id, presence: true
  field :start_at, presence: true
  field :league, presence: true
  field :country, presence: true

  def initialize(home_team_name:, away_team_name:, fixture_id:, start_at:, league:, country:) 
    @home_team_name = home_team_name
    @away_team_name = away_team_name
    @fixture_id = fixture_id
    @start_at = start_at
    @league = league
    @country = country
  end

  def perform
    super(Match)
  end
end