class UpdateTipOutcomeJob < ApplicationJob
  def perform(match_id)
    match = Match.find(match_id)

    MongoClient.connection do |collection|
      match.tips.each do |tip|
        collection.find(_id: BSON::ObjectId(tip.mongo_id)).each do |mongoTip|
          UpdateTip.perform(tip: tip, score: mongoTip['score'], outcome: mongoTip['outcome'])
        end
      end
    end
  end
end