require 'test_helper'

class FilterTipsTest < ActiveSupport::TestCase
  test 'success' do
    user = create(:user)
    match = create(:match, country: 'England')

    tip = create(
      :tip,
      match: match,
      user: user,
      approved_at: Time.now,
      odd: 1.5,
      bet: 'X'
    )
    in_acca = [create(:tip, match: match, user: user, approved_at: Time.now, bet: 'X', odd: 1.55).id]

    result = FilterTips.perform(
      max_odd: 1.7,
      min_odd: 1.5,
      bet_type: 'X',
      country: 'England',
      current_tips: in_acca
    )

    assert_equal 1, result.value.count
    assert_equal tip.bet, result.value[0].bet
    assert_equal tip.odd, result.value[0].odd
    assert_equal tip.match.country, result.value[0].match.country
  end

  test 'filter_by_odd' do
    user = create(:user)
    match = create(:match)

    [1.20, 1.5, 1.7, 2.0].each do |odd|
      create(:tip, match: match, user: user, approved_at: Time.now, odd: odd)
    end

    result = FilterTips.perform(max_odd: 1.7, min_odd: 1.5)

    assert_equal 2, result.value.count
  end

  test 'filter_by_bet' do
    user = create(:user)
    match = create(:match)

    ['1X', '2', 'X', 'BTTS'].each do |bet|
      create(:tip, match: match, user: user, approved_at: Time.now, bet: bet)
    end

    result = FilterTips.perform(bet_type: 'X')

    assert_equal 'X', result.value[0].bet
  end

  test 'filter_by_country' do
    user = create(:user)

    ['England', 'Spain', 'Germany'].each do |country|
      match = create(:match, country: country)
      create(:tip, match: match, user: user, approved_at: Time.now)
    end

    result = FilterTips.perform(country: 'England')

    assert_equal 'England', result.value[0].match.country
  end

  test 'filter_already_in_accumulation' do
    user = create(:user)
    match = create(:match)

    create_list(:tip, 4, match: match, user: user, approved_at: Time.now)
    in_acca = create_list(:tip, 2, match: match, user: user, approved_at: Time.now).map(&:id)

    result = FilterTips.perform(current_tips: in_acca)

    assert_equal 4, result.value.count
  end

  test 'filter by match_id' do
    user = create(:user)
    m1 = create(:match)
    m2 = create(:match)

    [m1, m2].each do |match|
      create_list(:tip, 3, match: match, user: user, approved_at: Time.now)
    end

    result = FilterTips.perform(match_id: m1.id)

    assert_equal 3, result.value.count
  end
end
