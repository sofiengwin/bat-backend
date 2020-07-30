require 'test_helper'

class FetchOffersQueryTest < ActionDispatch::IntegrationTest
  QUERY = <<-GQL
    query fetchOffers {
      fetchOffers {
        title
        link
      }
    }
  GQL

  test 'success' do
    create(:offer, approved_at: Time.now)

    post(
      graphql_path,
      params: {
        query: QUERY,
        variables: {}
      }
    )

    with_response_data do |json|
      assert_equal 1, json['fetchOffers'].count
    end
  end
end