module Queries
  class MeQuery < BaseResolver
    type Types::UserType, null: true

    def resolve
      context[:current_user] || GraphQL::ExecutionError.new("Something went wrong", extensions: { "user" => "notAuthorized" })
    end
  end
end