require 'test_helper'

class MeQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query me {
      me {
        email 
      }
    }
  GQL

  test 'success' do
    user = create(:user)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(user.id) },
      params: {
        query: QUERY,
      }
    )

    assert_json_data(
      'me' => {
        'email' => 'MyString'
      }
    )
  end

  test 'failure' do
    user = create(:user)

    post(
      graphql_path,
      params: {
        query: QUERY
      }
    )

    assert_equal 'User not authorised', JSON.parse(response.body)['errors'][0]['message']
  end
end