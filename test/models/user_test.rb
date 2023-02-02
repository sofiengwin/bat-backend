require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'scoring' do
    user = create(:user)

    [1.month.ago, Time.current, 3.days.from_now, 8.days.from_now].each do |awarded_at|
      create(
        :user_point_counter,
        user_id: user.id,
        awarded_at: awarded_at,
        point: 100
      )
    end

    assert_equal 400, user.total_points
    assert_equal 300, user.monthly_total
    assert_equal 200, user.weekly_total
  end
end
