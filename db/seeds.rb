# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# u1 = User.create(
#   name: 'Baddest',
#   username: 'Baddest bad guy'
# )
# u2 = User.create(
#   name: 'U2',
#   username: 'Baddest bad guy'
# )
# u3 = User.create(
#   name: 'U3',
#   username: 'Baddest bad guy'
# )

# users = [u1, u2, u3]

# 4.times do |n|
#   match = Match.create(
#     home_team_name: 'Manchester United',
#     away_team_name: 'Chelsea',
#     score: '2 - 2',
#     start_at: Time.now,
#     fixture_id: n + 1,
#     league: 'Premier League',
#     country: 'England'
#   )

#   rand(1...10).times do
#     user = users.sample
#     tip = Tip.create(
#       user: user,
#       match: match,
#       outcome: 'won',
#       bet: '1X',
#       odd: 1.55,
#       mongo_id: '4994jjdfjjkdf-jiriuejd-394ew'
#     )

#     Point.create(
#       value: 10,
#       tip: tip,
#       user: user
#     )
#   end
# end


# SELECT *, (SELECT COUNT(*) FROM tips WHERE tips.match_id  = m.id) AS tip_count FROM matches AS m ORDER BY tip_count DESC

mockUser = {
	name: "Ogbara Godwin",
	email: "sengodwin@gmail.com",
	access_token: "fake.access.token",
	token_id: "fake.token.id",
	provider_id: "f",
	avatar_url: "path/to/file.png"
}

[
  {
    provider: 'Betensured',
    name: 'The Dark One',
  },
  {
    provider: 'BetAdvice',
    name: 'General Seer',
  },
  {
    provider: 'Stats24',
    name: 'Idasboki',
  },
  {
    provider: 'AbrahamTips',
    name: 'Doctor Strange',
  },
  {
    provider: 'AFootballReport',
    name: 'Alabo Don Pato',
  },
  {
    provider: 'SoccerVista',
    name: 'Martinez D King',
  },
  {
    provider: 'olbg',
    name: 'Baaed Bunt',
  },
  {
    provider: 'ConfirmBets',
    name: 'DBello',
  },
].each do |provider|
  CreateUser.perform(**mockUser.merge(name: provider[:name], email: "#{provider[:provider]}@guru.com"), provider_id: rand(1...1000), approved_provider_at: Time.now)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?