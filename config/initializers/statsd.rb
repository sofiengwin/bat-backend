require 'datadog/statsd'

# Create a DogStatsD client instance.
STATSD = Datadog::Statsd.new('localhost', 8125)