require 'test_helper'

class FetchRankingTest <ActiveSupport::TestCase
  test 'success' do
    u1 = create(:user, name: 'u1')
    u2 = create(:user, name: 'u2')
    u3 = create(:user, name: 'u3')

    users = [u1, u2, u3]

    4.times do |n|
      match = create(:match)
    
      rand(1...10).times do
        user = users.sample
        tip = create(:tip, match: match, user: user)
        
        create(:point, pointable: tip, user: user, value: 10)
      end
    end

    result = FetchRanking.perform

    assert result.succeeded?
    assert_equal 3, result.value.count
    assert result.value[0].point > result.value[1].point
  end
end