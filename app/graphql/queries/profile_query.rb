module Queries
  class ProfileQuery < BaseResolver
    class ProfileType < Types::UserType
      field :accumulations, [Types::AccumulationType], Accumulation, null: true
      field :tips, [Types::TipType], null: true
      field :totalTips, Int, null: true
      field :totalWins, Int, null: true
      field :totalPoints, Int, null: true

      def accumulations
        AssociationLoader.for(User, :accumulations).load(object)
          .then { |result| result.sort }
      end

      def tips
        AssociationLoader.for(User, :tips).load(object)
          .then { |result| result.sort }
      end
    end

    argument :userId, ID, required: true, prepare: ->(id, _) { User.find_by_id(id) }, as: :user

    type ProfileType, null: false

    def resolve(user:)
      user || context[:current_user] || GraphQL::ExecutionError.new("Something went wrong", extensions: { "user" => "notFound" })
    end
  end
end