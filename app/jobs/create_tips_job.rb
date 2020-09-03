class CreateTipsJob < ApplicationJob
  def perform
    MongoClient.connection do |collection|
      collection.find({
        normalisedAt: { '$type' => 9},
        consumedAt: { '$type' => 10}
      }).each do |tip|
        create_tip_and_match(tip: tip)
      end
    end
  end

  private def create_tip_and_match(tip:)
    user = tip_by_user(tip: tip)
    match = Match.find_by_id(tip['fixtureId'])

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
      country: tip['country'],
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
      outcome: 'pending',
      approved_at: Time.now
    )
  end

  # update mongo db that the tip has been consumed
  private def update_consumed_at(tip:)
    tip.update('consumedAt' => Time.now)
  end

  private def tip_by_user(tip:)
    User.find_by_email("#{tip['provider']}@guru.com") || User.first
  end
end