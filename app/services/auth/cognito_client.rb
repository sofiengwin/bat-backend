module Auth
  class CognitoClient
    class << self
      def authorize(authorization_code)
        params = {
          grant_type: 'authorization_code',
          client_id: ENV['USERPOOL_CLIENT_ID'],
          code: authorization_code,
          redirect_uri: "http://localhost:3001"#ENV['USERPOOL_REDIRECT_URI']
        }

        response = JSON.parse(connection.post('/token', **params).body)

        response['id_token']
      end

      private

      def connection
        Faraday.new(
          url: ENV['AUTH_URL'],
          headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
        )
      end
    end
  end
end
