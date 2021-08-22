class FetchTrendingTips < Service::Base
  Trend = Struct.new(:homeTeamName, :awayTeamName, :country, :league, :tipCount, :matchId)

  def perform
    match_id_and_tips_count = Tip.approved.group(:match_id).current.count(:id).sort { |m_id_tips_count_a, m_id_tips_count_b|  m_id_tips_count_b[1] <=> m_id_tips_count_a[1] }[0..10]

    trends = match_id_and_tips_count.map do |(match_id, tips_count)|
      match = Match.find(match_id)
      Trend.new(match.home_team_name, match.away_team_name, match.country, match.league, tips_count, match.id)
    end

    Service::Result.resolve(trends)
  end
end
