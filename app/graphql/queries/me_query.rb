module Queries
  class MeQuery < BaseResolver
    type Types::UserType, null: true

    def resolve
      context[:current_user] || GraphQL::ExecutionError.new("User not authorised", extensions: { "user" => "notAuthorized" })
    end
  end
end