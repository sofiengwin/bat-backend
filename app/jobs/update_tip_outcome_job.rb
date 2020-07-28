class UpdateTipOutcomeJob < ApplicationJOb
  def perform(match_id)
    match = Match.find(match_id)

    MongoClient.connection do |collection|
      match.tips.each do |tip|
        mongoTip = collection.find_one(tip.mongo_id)

        if mongoTip
          UpdateTip.perform(tip: tip, score: mongoTip['score'], outcome: mongoTip['outcome'])
        end
      end
    end
  end
end