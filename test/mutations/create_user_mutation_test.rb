require 'test_helper'

class CreateUserMutationTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    mutation createUser($name: String, $email: String!, $accessToken: String, $tokenId: String, $providerId: String, $avatarUrl: String) {
      createUser(input: {name: $name, email: $email, accessToken: $accessToken tokenId: $tokenId, providerId: $providerId avatarUrl: $avatarUrl}) {
        userDetails {
          user {
            name
            email
            avatarUrl
          }
        }
        errors {
          field
          code
        }
      }
    }
  GQL

  test 'success' do
    post(
      graphql_path,
      headers: {},
      params: {
        query: QUERY,
        variables: {
          name: 'James Franco',
          email: 'james.franco@example.com',
          accessToken: 'fake.token',
          tokenId: 'fake.token.id',
          providerId: 'fake.provider.id',
          avatarUrl: 'path.to.avatar.jpg',
        }
      }
    )

    assert_json_data(
      'createUser' => {
        'userDetails' => {
          'user' => {
            'name' => 'James Franco',
            'email' => 'james.franco@example.com',
            'avatarUrl' => 'path.to.avatar.jpg',
          }
        },
        'errors' => nil
      }
    )
  end

  test 'failure' do
    post(
      graphql_path,
      headers: {},
      params: {
        query: QUERY,
        variables: {
          name: 'James Franco',
          email: '',
          accessToken: 'fake.token',
          tokenId: 'fake.token.id',
          providerId: 'fake.provider.id',
          avatarUrl: 'path.to.avatar.jpg',
        }
      }
    )

    assert_json_data(
      'createUser' => {
        'userDetails' => nil,
        'errors' => [
          { 'code' => 'blank', 'field' => 'email' }
        ]
      }
    )
  end

end