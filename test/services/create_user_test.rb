require 'test_helper'

class CreateUserTest < ActiveSupport::TestCase
  test 'success' do
    result = CreateUser.perform(attributes_for(:user))

    assert result.succeeded?
    assert result.value.email
    assert result.value.access_token
    assert result.value.token_id
    assert result.value.provider_id
    assert result.value.avatar_url
  end

  test 'find' do
    user = create(:user)
    result = CreateUser.perform(attributes_for(:user))

    assert result.succeeded?
    assert result.value.email
    assert result.value.access_token
    assert result.value.token_id
    assert result.value.provider_id
    assert result.value.avatar_url
  end

  test 'failure' do
    result = CreateUser.perform(attributes_for(:user, email: nil))

    assert result.failed?
    assert_errors [:blank], result.reason.details[:email]
  end
end