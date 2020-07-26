require 'test_helper'

class CreateMatchTest < ActiveSupport::TestCase
  test 'success' do
    result = CreateMatch.perform(
      home_team_name: 'Manchester United',
      away_team_name: 'Chelsea',
      fixture_id: '48998484',
      start_at: Time.now,
      league: 'Premier League',
      country: 'England'
    )

    assert result.succeeded?
    assert result.value.home_team_name
    assert result.value.away_team_name
    assert result.value.fixture_id
    assert result.value.start_at
    assert result.value.league
    assert result.value.country
  end

  test 'failure' do
    result = CreateMatch.perform(
      home_team_name: '',
      away_team_name: '',
      fixture_id: '',
      start_at: nil,
      league: '',
      country: ''
    )

    assert result.failed?
    assert_errors [:blank], result.reason.details[:home_team_name]
    assert_errors [:blank], result.reason.details[:away_team_name]
    assert_errors [:blank], result.reason.details[:fixture_id]
    assert_errors [:blank], result.reason.details[:start_at]
    assert_errors [:blank], result.reason.details[:league]
    assert_errors [:blank], result.reason.details[:country]
  end
end