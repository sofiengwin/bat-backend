require 'test_helper'

class FetchValueAccumulationsQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchValueAccumulations {
      fetchValueAccumulations {
        rating
        userName
        userId
        tips {
          bet
        }
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

      tips = create_list(:tip, rand(1...10), match: match, user: users.sample)

      accumulation = create(:accumulation, user: users.sample, approved_at: Time.now)
      accumulation.tips = tips
    end

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {}
      }
    )

    with_response_data do |json|
      assert_equal 4, json['fetchValueAccumulations'].count
    end
  end
end