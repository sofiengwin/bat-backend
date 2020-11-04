require 'test_helper'

class FetchBookmakersQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchBookmakers {
      fetchBookmakers {
        title
        link
      }
    }
  GQL

  test 'success' do
    create(:bookmaker, approved_at: Time.now)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {}
      }
    )

    with_response_data do |json|
      assert_equal 1, json['fetchBookmakers'].count
    end
  end
end