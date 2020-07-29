require 'test_helper'

class FetchTrendingTipsQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchTrending {
      fetchTrending {
        homeTeamName
        awayTeamName
        tipCount
      }
    }
  GQL

  test 'success' do
    user = create(:user)

    4.times do |n|
      match = create(:match)
    
      rand(1...10).times do
        create(:tip, match: match, user: user)
      end
    end

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {}
      }
    )

    with_response_data do |json|
      assert_equal 4, json['fetchTrending'].count
    end
  end
end