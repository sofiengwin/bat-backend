require 'test_helper'

class FetchRankingQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchRanking {
      fetchRanking {
        point
        name
      }
    }
  GQL

  test 'success' do
    u1 = create(:user, name: 'u1')
    u2 = create(:user, name: 'u2')
    u3 = create(:user, name: 'u3')

    users = [u1, u2, u3]

    4.times do |n|
      match = create(:match)
    
      rand(1...10).times do
        user = users.sample
        tip = create(:tip, match: match, user: user)
        create(:point, tip: tip, user: user, value: 10)
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
      assert_equal 3, json['fetchRanking'].count
    end
  end
end