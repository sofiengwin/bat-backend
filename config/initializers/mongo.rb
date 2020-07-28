require 'mongo'

class MongoClient
  def self.connection
    mongoInstance = Mongo::Client.new("mongodb+srv://bat:batcrawler@bat.cvu6c.mongodb.net/bat?retryWrites=true&w=majority")

    yield mongoInstance['crawlers']

  ensure
    mongoInstance.close
  end
end