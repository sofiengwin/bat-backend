require 'test_helper'

class FetchRankingQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchRanking {
      fetchRanking {
        weekly {
          point
          name
        }
        monthly {
          point
          name
        }
        total {
          point
          name
        }
      }
    }
  GQL

  test 'success' do
    u1 = create(:user, name: 'u1')
    u2 = create(:user, name: 'u2')
    u3 = create(:user, name: 'u3')

    users = [u1, u2, u3]

    users.each do |user|
      [1.month.ago, Time.current, 3.days.from_now, 8.days.from_now].each do |awarded_at|
        create(
          :user_point_counter,
          user_id: user.id,
          awarded_at: awarded_at,
          point: rand(100)
        )
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
      assert_equal 3, json['fetchRanking']['weekly'].count
      assert_equal 3, json['fetchRanking']['monthly'].count
      assert_equal 3, json['fetchRanking']['total'].count
    end
  end
end
