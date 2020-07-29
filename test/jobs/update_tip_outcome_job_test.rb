require 'test_helper'

class UpdateTipOutcomeJobTest < ActiveSupport::TestCase
  test 'success' do
    match = create(:match)
    tip = create(:tip, match: match, user: create(:user), mongo_id: '5f14a9d645d1c13e15275dd4')
    UpdateTipOutcomeJob.new.perform(match.id)
  end
end