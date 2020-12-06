require 'test_helper'

class CreateUserTipMutationTest < ActionDispatch::IntegrationTest
  test 'success' do
    user = create(:user)
    match = create(:match)
  end
end

