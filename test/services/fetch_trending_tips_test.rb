require 'test_helper'

class FetchTrendingTipsTest < ActiveSupport::TestCase
  test 'success' do
    user = create(:user)

    4.times do |n|
      match = create(:match)
    
      rand(1...10).times do
        create(:tip, match: match, user: user, approved_at: Time.current)
      end
    end

    result = FetchTrendingTips.perform()
    assert result.succeeded?
    assert_equal 4, result.value.count
    first_trend = result.value[0]
    second_trend = result.value[1]
    assert first_trend.tipCount > second_trend.tipCount
    assert first_trend.homeTeamName
    assert first_trend.awayTeamName
    assert first_trend.country
    assert first_trend.league
    assert first_trend.tipCount
  end
end