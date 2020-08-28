require 'test_helper'

class ViewAccumulationQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query profile($userId: ID!) {
      profile(userId: $userId) {
        id
        name
        totalTips
        totalWins
        totalPoints
        accumulations {
          id
          userName
        }
        tips {
          id
          bet
        }
      }
    }
  GQL

  test 'success' do
    user = create(:user, name: 'u1')
    match = create(:match)
    tips = create_list(:tip, 3, match: match, user: user)

    accumulation = create(:accumulation, user: user, approved_at: Time.now)
    accumulation.tips = tips

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          userId: user.id,
        }
      }
    )

    with_response_data do |json|
      assert_equal 1, json['profile']['accumulations'].count
      assert_equal 3, json['profile']['tips'].count
    end
  end

  test 'failure' do
    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          userId: 8494040030,
        }
      }
    )

    with_response_errors do |errors|
      assert_equal 'Something went wrong', errors[0]['message']
    end
  end
end