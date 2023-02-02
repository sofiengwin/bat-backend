require 'test_helper'

class CreateUserTipMutationTest < ActionDispatch::IntegrationTest
  mock_cognito_token = "eyJraWQiOiIwOUhCdDZySm1kTWRcL0hVOUNTU1NoTjZYYmdmV1ZoRnQ4XC9YaTNJa1Rmbms9IiwiYWxnIjoiUlMyNTYifQ.eyJhdF9oYXNoIjoiT0hXU3RJaGp6Mnlta1kxSGM4RXh1QSIsInN1YiI6ImVhOTlmZWRhLTk0ZjQtNGMxYy1iNDNlLTlmNGNiYjIwODM1NiIsImNvZ25pdG86Z3JvdXBzIjpbInVzLWVhc3QtMV9OTW9pWVZrVDBfR29vZ2xlIl0sImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLnVzLWVhc3QtMS5hbWF6b25hd3MuY29tXC91cy1lYXN0LTFfTk1vaVlWa1QwIiwiY29nbml0bzp1c2VybmFtZSI6Imdvb2dsZV8xMTQ3Mjk3MTk4MzAwNDgzODE4MzAiLCJnaXZlbl9uYW1lIjoiU2FpbnQiLCJwaWN0dXJlIjoiaHR0cHM6XC9cL2xoMy5nb29nbGV1c2VyY29udGVudC5jb21cL2FcL0FFZEZUcDdEYk1iX1dtdE1yWjNCTXkwbzloSS1pWnJqTTM5S0RHVlNfWTZqPXM5Ni1jIiwib3JpZ2luX2p0aSI6IjVkNjMwM2E4LWFhY2MtNGYzMy1hMWRiLThhMTNhZDU5NjJhOCIsImF1ZCI6InVhbnQ1dWljbGZhZnQxMW04NjdtN3FoMDgiLCJpZGVudGl0aWVzIjpbeyJ1c2VySWQiOiIxMTQ3Mjk3MTk4MzAwNDgzODE4MzAiLCJwcm92aWRlck5hbWUiOiJHb29nbGUiLCJwcm92aWRlclR5cGUiOiJHb29nbGUiLCJpc3N1ZXIiOm51bGwsInByaW1hcnkiOiJ0cnVlIiwiZGF0ZUNyZWF0ZWQiOiIxNjY0MjA2NzUyODE5In1dLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTY3Mzc0MDk0OSwibmlja25hbWUiOiJTYWludCBHb2R3aW4iLCJleHAiOjE2NzM3NDQ1NDksImlhdCI6MTY3Mzc0MDk0OSwiZmFtaWx5X25hbWUiOiJHb2R3aW4iLCJqdGkiOiI0NDVmOTVhMC0xYmFkLTQwMjYtOWIzOC0yMTE3ODhjNDcxZGEiLCJlbWFpbCI6InNlbmdvZHdpbkBnbWFpbC5jb20ifQ.aNrz-I31C46jIc58C7Oy1U5dq6IUBZRDddPBYSZlrhyPW-gUQLQn-kypP1lEhKzjdo3ND1BxTiYtiKDgnriMMsQxqXc3W7v6SD6TuAS0EcQ-YMmpiaQEvTWqAZh_4jqWdegffcIvAX_9zcilS1EgRsOtAabG-mEE7Ertz0oKpO-dgAuWzZG0_IkpClOUkNq3MIk9OmicDoko8d-UcXCzCEVdk2buwsDz7QSFNEcUxvNx_leYIflcHeZroB7a8uBhQjSEMqk40K4dk6gGmhHmp3eJ2eIy5vGqfZUNNHKZ5K6g7FSdPNhh2QlMn1PoDalxCwkrIgIJ0H27A6VYWIaR9w"
  QUERY = <<-GQL
    mutation createUserTip($homeTeamName: String!, $awayTeamName: String!, $fixtureId: ID!, $league: String!, $country: String!, $bet: String!, $betCategory: String!, $odd: String!, $startAt: String!) {
      createUserTip(input: {homeTeamName: $homeTeamName, awayTeamName: $awayTeamName, fixtureId: $fixtureId, league: $league, country: $country, bet: $bet, betCategory: $betCategory, odd: $odd, startAt: $startAt}) {
        tip {
          bet
          betCategory
          odd
          match {
            homeTeamName
            awayTeamName
            fixtureId,
            league
            country
            startAt
          }
        }
        errors {
          field
          code
        }
      }
    }
  GQL

  test 'success' do
    user = create(:user)
    start_at = "2023-01-21T12:30:00+00:00"
    post(
      graphql_path,
      headers: {'Authorization' => token_for_user(user.id)},
      params: {
        query: QUERY,
        variables: {
          homeTeamName: 'Manchester United',
          awayTeamName: 'Chelsea',
          fixtureId: 7678998,
          league: 'Premier League',
          country: 'England',
          bet: 'Match Winner',
          betCategory: 'Home Win',
          odd: '1.55',
          startAt: start_at.to_i,
        }
      }
    )

    assert_equal 200, response.status
    binding.pry
    assert_json_data(
      'createUserTip' => {
        'tip' => {
          'bet' => 'Match Winner',
          'betCategory' => 'Home Win',
          'odd' => 1.55,
          'match' => {
            'homeTeamName' => 'Manchester United',
            'awayTeamName' => 'Chelsea',
            'league' => 'Premier League',
            'country' => 'England',
            'fixtureId' => 7678998,
            'startAt' => start_at.to_datetime,
          }
        },
        'errors' => nil
      }
    )
  end

  test 'failure' do
    post(
      graphql_path,
      headers: {},
      params: {
        query: QUERY,
        variables: {
          name: 'James Franco',
          accessCode: 'Invalid.Access.Code',
          approvedProviderAt: 'fake.token.id',
        }
      }
    )

    assert_json_data(
      'createUserTip' => {
        'tip' => nil,
        'errors' => [
          { 'code' => 'invalid', 'field' => 'providerId' }
        ]
      }
    )
  end
end

