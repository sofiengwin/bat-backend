require 'test_helper'

class UpdateTipTest < ActiveSupport::TestCase
  test 'success' do
    tip = create(:tip, match: create(:match, score: nil), user: create(:user))

    result = UpdateTip.perform(tip: tip, outcome: 'won', score: '2 - 2')

    assert result.succeeded?
    assert_equal 'won', result.value.outcome
    assert_equal '2 - 2', result.value.match.score
  end
end