SIDEKIQ_REDIS_URL = Rails.env.test? ? ENV['TEST_SIDEKIQ_REDIS_URL'] : ENV['REDIS_URL']

sidekiq_redis = { url: SIDEKIQ_REDIS_URL }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_redis

  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_redis
end