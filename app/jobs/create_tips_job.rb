class CreateTipsJob < ApplicationJob
  def perform
    MongoClient.connection do |collection|
      collection.find({
        normalisedAt: { '$type' => 9 },
        consumedAt: { '$type' => 10 },
        eventTimestamp: { '$gte' => Time.now.beginning_of_day },
      }).each do |tip|
        create_tip_and_match(tip: tip, collection: collection)
      end
    end
  end

  private def create_tip_and_match(tip:, collection:)
    user = tip_by_user(tip: tip)
    match = Match.find_by_fixture_id(tip['fixtureId'])

    if match
      create_tip(tip: tip, match: match, user: user)
    else
      create_match(tip: tip)
        .then { |m| create_tip(tip: tip, match: m, user: user) }
        .on_success { update_consumed_at(tip: tip, collection: collection) }
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
      odd: tip['odd'] || 1.50,
      mongo_id: tip['_id'],
      outcome: 'pending',
    )
  end

  # update mongo db that the tip has been consumed
  private def update_consumed_at(tip:, collection:)
    collection.update_one(
      { '_id' => BSON::ObjectId(tip['_id']) },
      {
        '$set' => { "consumedAt" => Time.now },
      }
    )
  end

  private def tip_by_user(tip:)
    User.find_by_email("#{tip['provider']}@guru.com") || User.first
  end
end