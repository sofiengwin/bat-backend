class FetchTrendingTips < Service::Base
  Trend = Struct.new(:homeTeamName, :awayTeamName, :country, :league, :tipCount, :matchId)

  def perform
    match_id_and_tips_count = Tip.approved.group(:match_id).count(:id)
    matches = Match.where(id: match_id_and_tips_count.keys).limit(10)

    trends = matches.map do |match|
      Trend.new(match.home_team_name, match.away_team_name, match.country, match.league, match_id_and_tips_count[match.id], match.id)
    end
 
    Service::Result.resolve(
      trends.sort{ |a, b| b.tipCount <=> a.tipCount }
    )
  end
end
