require 'test_helper'

class UpdateAccumulationJobTest < ActiveSupport::TestCase
	test 'success' do
		user = create(:user, approved_provider_at: Time.now)
		accumulation = create(:accumulation, user_id: user.id, created_at: Date.today)
		accumulation.tips = create_list(:tip, 3, match: create(:match), user: user, outcome: 'won')
		pp accumulation.tips
		refute accumulation.point
		UpdateAccumulationJob.new.perform
		
		assert accumulation.reload.point
	end  
end