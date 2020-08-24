require 'test_helper'

class BetGeneratorQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query betGenerator($minOdd: Float, $maxOdd: Float, $totalOdds: Float) {
      betGenerator(minOdd: $minOdd, maxOdd: $maxOdd, totalOdds: $totalOdds) {
        id
        odd
      }
    }
  GQL

  test 'success' do
    user = create(:user)
    match = create(:match)
    [1.12, 1.3, 1.25, 1.40, 1.6, 1.7, 1.20].each do |odd|
      create(:tip, odd: odd, user: user, match: match)
    end

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          minOdd: 1.2,
          maxOdd: 1.7,
          totalOdds: 4.00
        }.to_json
      }
    )

    with_response_data do |json|
      assert_equal 4, json['betGenerator'].count
    end
  end
end