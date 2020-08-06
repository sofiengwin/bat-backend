require 'mongo'

class MongoClient
  def self.connection
    mongoInstance = Mongo::Client.new(ENV['MONGO_URL'])

    yield mongoInstance['crawlers']

  ensure
    mongoInstance.close
  end
end