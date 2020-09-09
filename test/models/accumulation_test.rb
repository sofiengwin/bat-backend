require 'test_helper'

class AccumulationTest < ActiveSupport::TestCase
  test '.current' do
    create_list(:accumulation, 2, user: create(:user))
    create_list(:accumulation, 3, user: create(:user), created_at: 2.days.ago)

    assert_equal 2, Accumulation.current.count
  end
end
