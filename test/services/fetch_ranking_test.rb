require 'test_helper'

class FetchRankingTest <ActiveSupport::TestCase
  test 'success' do
    u1 = create(:user, name: 'u1')
    u2 = create(:user, name: 'u2')
    u3 = create(:user, name: 'u3')

    users = [u1, u2, u3]

    users.each do |user|
      [1.month.ago, Time.current, 3.days.from_now, 8.days.from_now].each do |awarded_at|
        create(
          :user_point_counter,
          user_id: user.id,
          awarded_at: awarded_at,
          point: rand(100)
        )
      end
    end

    result = FetchRanking.perform

    assert result.succeeded?
    assert_equal result.value['weekly'].count, 3
    assert_equal result.value['monthly'].count, 3
    assert_equal result.value['total'].count, 3
    assert result.value['weekly'][0].point > result.value['weekly'][1].point
    assert result.value['monthly'][0].point > result.value['monthly'][1].point
    assert result.value['total'][0].point > result.value['total'][1].point
  end
end
