module Mutations
  class CreateUserMutation < BaseMutation
    argument :name, String, required: false
    argument :username, String, required: true
    argument :email, String, required: true
    argument :accessToken, String, required: false
    argument :tokenId, String, required: false
    argument :providerId, String, required: false
    argument :avatarUrl, String, required: false

    field :user, Types::UserType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(**inputs)
      result = CreateUser.perform(
        name: inputs[:name],
        username: inputs[:username],
        email: inputs[:email],
        access_token: inputs[:accessToken],
        token_id: inputs[:tokenId],
        provider_id: inputs[:providerId],
        avatar_url: inputs[:avatarUrl],
      )

      if result.succeeded?
        { user: result.value }
      else
        { errors: ServiceError.from(result.reason) }
      end
    end
  end
end