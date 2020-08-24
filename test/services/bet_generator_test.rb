require 'test_helper'

class BetGeneratorTest < ActiveSupport::TestCase
  test 'success' do
    user = create(:user)
    match = create(:match)
    [1.12, 1.3, 1.25, 1.40, 1.6, 1.7, 1.20].each do |odd|
      create(:tip, odd: odd, user: user, match: match)
    end
    
    result = BetGenerator.perform(min_odd: 1.20, max_odd: 1.70, total_odds: 4.00)

    assert result.succeeded?

    pp result.value
  end
end