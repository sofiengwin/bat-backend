require 'test_helper'

class BetGeneratorTest < ActiveSupport::TestCase
  test 'success' do
    user = create(:user)
    match = create(:match)
    create_list(:tip, 6, odd: 1.5, user: user, match: match)
    
    result = BetGenerator.perform(min_odd: 1.2, max_odd: 1.7, total_odd: 4)

    assert result.succeeded?

    pp result.value
  end
end