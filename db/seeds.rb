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

homes = ['Aston Villa', 'Brentford', 'Everton', 'Arsenal', 'Chelsea']
aways = ['Manchester United', 'Manchester City', 'Westham', 'Leeds United', 'Fulham']
bet_categories = ['1 x 2', 'Over 2.5', 'Double Chance', 'Halftime/Fulltime']
bets = ['X', '1', '2', '1X', 'X2', 'Over.25']

users = User.all

100.times do |n|
  match = Match.create(
    home_team_name: homes.sample,
    away_team_name: aways.sample,
    score: '2 - 2',
    start_at: Time.now,
    fixture_id: rand(100000),
    league: 'Premier League',
    country: 'England'
  )

  user = users.sample
  tip = Tip.create(
    user: user,
    match: match,
    outcome: 'won',
    bet: bets.sample,
    bet_category: bet_categories.sample,
    odd: 1.55,
    mongo_id: '4994jjdfjjkdf-jiriuejd-394ew',
    approved_at: Time.now
  )
end


# # SELECT *, (SELECT COUNT(*) FROM tips WHERE tips.match_id  = m.id) AS tip_count FROM matches AS m ORDER BY tip_count DESC

# mockUser = {
# 	name: "King Tiper",
# 	email: "king.tipper@gmail.com",
# 	access_token: "fake.access.token",
# 	token_id: "fake.token.id",
# 	provider_id: "f",
# 	avatar_url: "path/to/file.png"
# }

# [
#   {
#     provider: 'Betensured',
#     name: 'The Dark One',
#   },
#   {
#     provider: 'BetAdvice',
#     name: 'General Seer',
#   },
#   {
#     provider: 'Stats24',
#     name: 'Idasboki',
#   },
#   {
#     provider: 'AbrahamTips',
#     name: 'Doctor Strange',
#   },
#   {
#     provider: 'AFootballReport',
#     name: 'Alabo Don Pato',
#   },
#   {
#     provider: 'SoccerVista',
#     name: 'Martinez D King',
#   },
#   {
#     provider: 'olbg',
#     name: 'Baaed Bunt',
#   },
#   {
#     provider: 'ConfirmBets',
#     name: 'DBello',
#   },
# ].each do |provider|
#   CreateUser.perform(**mockUser.merge(name: provider[:name], email: "#{provider[:provider]}@guru.com"), provider_id: rand(1...1000), approved_provider_at: Time.now)
# end

# AdminUser.create(email: 'admin@example.com', password: 'password')

# users.each do |user|
#   20.times do
#     pp user.name
#     user.user_point_counters.create({awarded_at: rand(100).days.ago, point: rand(50..100)})
#   end
# end
