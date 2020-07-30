class FetchTrendingTips < Service::Base
  QUERY = "SELECT *, (SELECT COUNT(*) FROM tips WHERE tips.match_id  = m.id) AS tip_count FROM matches AS m ORDER BY tip_count DESC"

  Trend = Struct.new(:home_team_name, :away_team_name, :country, :league, :tip_count)

  def perform
    today = Time.now
    trends = Match.find_by_sql(QUERY).map do |match|
      Trend.new(match.home_team_name, match.away_team_name, match.country, match.league, match.attributes['tip_count'])
    end
 
    Service::Result.resolve(trends)
  end
end