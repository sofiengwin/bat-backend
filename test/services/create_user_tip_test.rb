require 'test_helper'

class CreateUserTipTest < ActiveSupport::TestCase
  def args(fixture_id: nil)
    {
      home_team_name: 'Man Utd',
      away_team_name: 'Chelsea',
      fixture_id: fixture_id || rand(10),
      league: 'Premier League',
      country: 'England',
      bet: '1',
      user: create(:user),
      odd: 1.55,
      start_at: 4.hours.ago.to_i,
      mongo_id: 'rand(10)'
    }
  end

  test 'success' do
    result = CreateUserTip.perform(args)
    
    assert result.succeeded?
    assert result.value
    assert result.value.match
    assert_equal 'Man Utd', result.value.match.home_team_name
    assert_equal 'Chelsea', result.value.match.away_team_name
  end
end