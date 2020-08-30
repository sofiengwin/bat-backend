class NormalizrJob < ApplicationJob
  def perform
    Net::HTTP.get(URI("#{ENV['CRAWLER_BASE']}/normalizr"))
  end
end