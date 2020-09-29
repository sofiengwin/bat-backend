class FetchTrendingTips < Service::Base
  QUERY = "SELECT *, (SELECT COUNT(*) FROM tips WHERE tips.match_id  = m.id) AS tip_count FROM matches AS m ORDER BY tip_count DESC LIMIT 10"

  Trend = Struct.new(:home_team_name, :away_team_name, :country, :league, :tip_count, :match_id)

  def perform
    today = Time.now
    
    match_id_and_tips_count = Tip.approved.current.group(:match_id).count(:id)
    matches = Match.find(match_id_and_tips_count.keys)
    # binding.pry
    trends = matches.map do |match|
      Trend.new(match.home_team_name, match.away_team_name, match.country, match.league, match_id_and_tips_count[match.id], match.id)
    end
 
    Service::Result.resolve(
      trends.sort{ |a, b| b.tip_count <=> a.tip_count }
    )
  end
end