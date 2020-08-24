require 'test_helper'

class BetGeneratorQueryTest < ActionDispatch::IntegrationTest
  QUERY = `
    query betGenerator($minOdd: Float, $maxOdd: Float, $totalOdds: Float) {
      betGenerator(minOdd: $minOdd, maxOdd: $maxOdd, totalOdds: $totalOdds) {
        tip {
          id
        }
      }
    }
  `

  test 'success' do
    user = create(:user)
    match = create(:match)
    create_list(:tip, 6, odd: 1.5, user: user, match: match)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          minOdd: 1.2,
          maxOdd: 1.7,
          totalOdd: 4
        }
      }
    )
    pp response.body
    with_response_data do |json|
      pp json
    end
  end
end