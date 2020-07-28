require 'test_helper'

class CreateTipsJobTest < ActiveSupport::TestCase
  test 'success' do
    user = create(:user)

    stub_request(:put, "https://bat-shard-00-02.cvu6c.mongodb.net")
      .to_return(status: 200, body: "", headers: {})

   assert_difference -> {Tip.count}, 1 do
     CreateTipsJob.new.perform
   end
  end
end