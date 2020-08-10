require 'test_helper'

class CreateAccumulationMuationTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    mutation createAccumulation ($tips: [ID!]!) {
      createAccumulation(input: {tips: $tips}) {
        accumulation {
          tips {
            match {
              homeTeamName
              awayTeamName
            }
            bet
          }
        }
      }
    }
  GQL

  test 'success' do
    user = create(:user)
    match = create(:match)
    tips = create_list(:tip, 3, user: user, match: match)

    post(
      graphql_path,
      headers: { 'Authorization' => token_for_user(user.id) },
      params: {
        query: QUERY,
        variables: {
          tips: tips.map(&:id)
        }.to_json
      }
    )
    
    assert_json_data(
      'createAccumulation' => {
        'accumulation' => {
          'tips' => [
            {'match' => {'homeTeamName' => 'MyString', 'awayTeamName' => 'MyString'}, 'bet' => '1X'},
            {'match' => {'homeTeamName' => 'MyString', 'awayTeamName' => 'MyString'}, 'bet' => '1X'},
            {'match' => {'homeTeamName' => 'MyString', 'awayTeamName' => 'MyString'}, 'bet' => '1X'},
          ]
        }
      }
    )
  end

  test 'failure' do
    user = create(:user)
    match = create(:match)
    tips = create_list(:tip, 3, user: user, match: match)

    post(
      graphql_path,
      headers: { },
      params: {
        query: QUERY,
        variables: {
          userId: user.id,
          tips: tips.map(&:id)
        }.to_json
      }
    )

    assert_equal 'User not authorised', JSON.parse(response.body)['message']
  end
end