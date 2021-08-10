require 'test_helper'

class CreateTipTest < ActiveSupport::TestCase
  test 'success' do
    match = create(:match)
    user = create(:user)

    result = CreateTip.perform(rating: 80, bet: '1X', match: match, user: user, odd: 12.34, mongo_id: 'gjhdskj-djhsk-378393-js')

    assert result.succeeded?
    assert result.value.rating
    assert result.value.bet
    assert result.value.match
    assert result.value.user
    assert result.value.odd
    assert result.value.mongo_id
  end

  test 'failure' do
    result = CreateTip.perform(rating: 80, bet: '', match: nil, user: nil, mongo_id: nil)
    pp result
    assert result.failed?
    assert_errors [:blank], result.reason.details[:bet]
    assert_errors [:blank], result.reason.details[:user]
    assert_errors [:blank], result.reason.details[:match]
    assert_errors [:blank], result.reason.details[:mongo_id]
  end
end