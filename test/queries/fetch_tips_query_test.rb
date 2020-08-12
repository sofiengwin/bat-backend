require 'test_helper'

class FetchTipsQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchTips {
      fetchTips {
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
    create(:tip, user: create(:user), match: create(:match))

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {}
      }
    )

    with_response_data do |json|
      pp json
      assert_equal 1, json['fetchTips'].count
    end
  end
end