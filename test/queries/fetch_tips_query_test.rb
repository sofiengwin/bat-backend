require 'test_helper'

class FetchTipsQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchTips ($betType: String, $country: String, $maxOdd: Float, $minOdd: Float, $currentTips: [ID!]!) {
      fetchTips (betType: $betType, country: $country, maxOdd: $maxOdd, minOdd: $minOdd, currentTips: $currentTips) {
        bet
        outcome
        match {
          homeTeamName
          awayTeamName
        }
      }
    }
  GQL

  test 'success' do
    create(:tip, user: create(:user), match: create(:match), approved_at: Time.now)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          currentTips: [1]
        }
      }
    )

    with_response_data do |json|
      pp json
      assert_equal 1, json['fetchTips'].count
    end
  end
end