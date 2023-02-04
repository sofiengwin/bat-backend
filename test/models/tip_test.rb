require 'test_helper'

class TipTest < ActiveSupport::TestCase
  test 'awarding point-when updating tip outcome to won' do
    user = create(:user)
    tip = create(:tip, user: user, match: create(:match))

    assert_equal 0, user.user_point_counters.count
    tip.update(outcome: 'won')
    assert_equal 1, user.user_point_counters.count
    assert_equal 20, user.user_point_counters.first.point
  end

  test 'awarding point-when updating something else on tip' do
    user = create(:user)
    tip = create(:tip, user: user, match: create(:match))

    assert_equal 0, user.user_point_counters.count
    tip.update(odd: 3.12)
    assert_equal 0, user.user_point_counters.count
  end
end
