class CrawlerJob < ApplicationJob
  def perform
    Net::HTTP.get(URI("#{ENV['CRAWLER_BASE']}/crawl"))
  end
end