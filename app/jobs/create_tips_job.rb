class CreateTipsJob < ApplicationJob
  def perform
    MongoClient.connection do |collection|
      collection.find().each do |tip|
        create_tip_and_match(tip: tip)
      end
    end
  end

  private def create_tip_and_match(tip:)
    user = User.first
    match = Match.find_by_id(tip['fixtureId'] || rand(1...20))

    if match
      create_tip(tip: tip, match: match, user: user)
    else
      create_match(tip: tip)
        .then { |m| create_tip(tip: tip, match: m, user: user) }
        .on_success { update_consumed_at(tip: tip) }
    end
  end

  private def create_match(tip:)
    CreateMatch.perform(
      home_team_name: tip['homeTeam'],
      away_team_name: tip['awayTeam'],
      fixture_id: tip['fixtureId'],
      start_at: tip['eventTimestamp'],
      league: tip['league'],
      country: tip['country']
    )
  end

  private def create_tip(tip:, match:, user:)
    CreateTip.perform(
      rating: tip['accuracy'],
      bet: tip['bet'],
      match: match,
      user: user,
      odd: tip['odd'],
      mongo_id: tip['_id'],
    )
  end

  # update mongo db that the tip has been consumed
  private def update_consumed_at(tip:)
    tip.update('consumedAt' => Time.now)
  end
end