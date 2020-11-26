module Mutations
  class CreateUserTipMutation < BaseMutation
    argument :homeTeamName, String, required: true
    argument :awayTeamName, String, required: true
    argument :fixtureId, String, required: true
    argument :league, String, required: true
    argument :country, String, required: true
    argument :bet, String, required: true
    argument :odd, String, required: true
    argument :startAt, String, required: true

    field :tip, Types::TipType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(**args)
      return { errors: [ServiceError.new(:admin, 'notAuthorized')] } unless context[:current_user]
      result = CreateUserTip.perform(
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
        home_team_name: args[:homeTeamName],
      )

      if result.succeeded?
        { tip: result.value }
      else
        { errors: ServiceError.from(result.reason) }
      end
    end
  end
end