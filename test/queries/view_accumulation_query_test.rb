require 'test_helper'

class ViewAccumulationQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query viewAccumulation($accumulationId: ID!) {
      viewAccumulation(accumulationId: $accumulationId) {
        accumulation {
          userName
          day
          tips {
            bet
          }
        }
        availableTips {
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
    create_list(:tip, 3, match: match, user: user, approved_at: Time.now)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          accumulationId: accumulation.id,
        }
      }
    )

    with_response_data do |json|
      assert_equal 3, json['viewAccumulation']['accumulation']['tips'].count
      assert_equal 3, json['viewAccumulation']['availableTips'].count
    end
  end

  test 'failure' do
    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {
          accumulationId: 43789490409,
        }
      }
    )

    with_response_errors do |errors|
      assert_equal 'Something went wrong', errors[0]['message']
    end
  end
end