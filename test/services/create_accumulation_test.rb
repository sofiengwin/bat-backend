require 'test_helper'

class CreateAccumulationTest < ActiveSupport::TestCase
  test 'success' do
    user = create(:user)
    result = CreateAccumulation.perform(tips: [1, 3, 4], user_id: user.id, rating: 80)

    assert result.succeeded?
    assert result.value.tips
    assert result.value.user_id
    assert result.value.rating
  end

  test 'failure' do
    user = create(:user)
    result = CreateAccumulation.perform(tips: [1, 3, 4], user_id: nil, rating: 80)

    assert result.failed?
    assert_errors [:blank], result.reason.details[:user_id]
  end
end