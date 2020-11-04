require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'scoring' do
    user = create(:user)
    match = create(:match)
    ['pending', 'won'].each do |outcome|
      create_list(:tip, 5, outcome: outcome, user: user, match: match)
      create_list(:accumulation, 5, user: user, outcome: outcome)
    end

    create_list(:point, 10, user: user, pointable: Tip.last, value: 10)

    assert_equal 10, user.total_tips
    assert_equal 5, user.total_wins
    assert_equal 100, user.total_points
  end
end
