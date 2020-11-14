class FetchTrendingTips < Service::Base
  Trend = Struct.new(:home_team_name, :away_team_name, :country, :league, :tip_count, :match_id)

  def perform
    match_id_and_tips_count = Tip.approved.group(:match_id).count(:id)
    matches = Match.where(id: match_id_and_tips_count.keys).limit(10)

    trends = matches.map do |match|
      Trend.new(match.home_team_name, match.away_team_name, match.country, match.league, match_id_and_tips_count[match.id], match.id)
    end
 
    Service::Result.resolve(
      trends.sort{ |a, b| b.tip_count <=> a.tip_count }
    )
  end
end
