require 'test_helper'

class AwardPointTest < ActiveSupport::TestCase
  test 'success' do
    tip = create(
      :tip,
      match: create(:match, score: nil),
      user: create(:user),
      odd: 1.55
    )

    result = AwardPoint.perform(tip: tip)

    assert result.succeeded?
    assert_equal tip.user_id, result.value.user_id
    assert_equal 15, result.value.point
    assert result.value.awarded_at
  end

  test 'same week - updates existing user point counter record' do
    tip = create(
      :tip,
      match: create(:match, score: nil),
      user: create(:user),
      odd: 1.55
    )

    current_user_point_counter = create(
      :user_point_counter,
      user_id: tip.user_id,
      awarded_at: Time.current,
      point: 100
    )

    result = AwardPoint.perform(tip: tip)

    assert result.succeeded?
    assert_equal tip.user_id, result.value.user_id
    assert_equal 115, result.value.point
    assert result.value.awarded_at
  end

  test 'new week - creates new user point counter record' do
    tip = create(
      :tip,
      match: create(:match, score: nil),
      user: create(:user),
      odd: 1.55
    )

    current_user_point_counter = create(
      :user_point_counter,
      user_id: tip.user_id,
      awarded_at: 1.week.from_now,
      point: 100
    )

    result = AwardPoint.perform(tip: tip)

    assert result.succeeded?
    assert_equal tip.user_id, result.value.user_id
    assert_equal 15, result.value.point
    assert result.value.awarded_at
  end
end
