module Mutations
  class CreateUserMutation < BaseMutation
    class FindOrCreateType < Types::BaseObject
      field :user, Types::UserType, null: false
      field :hhh, String, null: false
    end

    argument :name, String, required: false
    argument :email, String, required: true
    argument :accessToken, String, required: false
    argument :tokenId, String, required: false
    argument :providerId, String, required: false
    argument :avatarUrl, String, required: false

    field :user, FindOrCreateType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(**inputs)
      result = CreateUser.perform(
        name: inputs[:name],
        email: inputs[:email],
        access_token: inputs[:accessToken],
        token_id: inputs[:tokenId],
        provider_id: inputs[:providerId],
        avatar_url: inputs[:avatarUrl],
      )

      if result.succeeded?
        { user: result.value , hhh: ActionToken.encode(result.value.id, scope: 'login')}
      else
        { errors: ServiceError.from(result.reason) }
      end
    end
  end
end