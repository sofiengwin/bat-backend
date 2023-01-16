module Mutations
  class CreateUserMutation < BaseMutation
    class FindOrCreateType < Types::BaseObject
      field :user, Types::UserType, null: false, hash_key: :user
      field :accessToken, String, null: false, hash_key: :accessToken
    end

    argument :name, String, required: false
    argument :accessCode, String, required: true
    argument :approvedProviderAt, String, required: false

    field :userDetails, FindOrCreateType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(**inputs)
      cognito_user, = cognito_user_details(inputs[:accessCode])
      unless cognito_user
        return { errors: [{'code': 'invalid', 'field': 'providerId'}] }
      end

      result = CreateUser.perform(
        name: inputs[:name] || cognito_user&.fetch('nickname'),
        provider_id: cognito_user.fetch('sub'),
        email: cognito_user.fetch('email'),
        avatar_url: cognito_user.fetch('picture'),
        approved_provider_at: inputs[:approvedProviderAt],
      )

      if result.succeeded?
        { userDetails: {user: result.value, accessToken: ActionToken.encode(result.value.id, scope: 'login')} }
      else
        { errors: ServiceError.from(result.reason) }
      end
    end

    def cognito_user_details(access_code)
      cognito_token = Auth::CognitoClient.authorize(access_code)

      return unless cognito_token

      JWT.decode(cognito_token, false, nil)
    rescue JWT::DecodeError
      nil
    end
  end
end
