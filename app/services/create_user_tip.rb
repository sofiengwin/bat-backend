class CreateUserTip < Service::Base
	field :home_team_name
	field :away_team_name
	field :fixture_id
	field :league
	field :country
	field :bet
	field :user
	field :odd
	field :start_at
	field :mongo_id

	validate :more_than_three_hours_to_match?
	validate :only_three_games_per_day?

	def initialize(**options)
		@home_team_name = options[:home_team_name]
		@away_team_name = options[:away_team_name]
		@fixture_id = options[:fixture_id]
		@league = options[:league]
		@country = options[:country]
		@bet = options[:bet]
		@user = options[:user]
		@odd = options[:odd] || 1.55
		@start_at = options[:start_at]
		@mongo_id = options[:mongo_id]
	end

	def perform
		return Service::Result.reject(errors) unless valid?

		@match = Match.find_by_fixture_id(fixture_id)

		if @match
			create_tip(match: @match)
		else
			create_match
				.then { |m| create_tip(match: m) }
		end
	end

	private def create_tip(match:)
		CreateTip.perform(
      bet: bet,
      match: match,
      user: user,
      odd: odd || 1.55,
			mongo_id: mongo_id,
		)
	end

	private def create_match
    CreateMatch.perform(
      home_team_name: home_team_name,
      away_team_name: away_team_name,
      fixture_id: fixture_id,
      start_at: start_at,
      league: league,
      country: country
		)
	end
	
	private def more_than_three_hours_to_match?
		return unless Time.at(start_at) > 3.hours.ago

		errors.add(:bettingClosed, message: 'Prediction has closed for this match')
	end

	private def only_three_games_per_day?
		return unless user.tips.current.count > 3

		errors.add(:predictionLimit, message: 'You can predict at most three matches in a day')
	end
end