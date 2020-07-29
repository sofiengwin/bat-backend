# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: 'Baddest',
  username: 'Baddest bad guy'
)

4.times do |n|
  match = Match.create(
    home_team_name: 'Manchester United',
    away_team_name: 'Chelsea',
    score: '2 - 2',
    start_at: Time.now,
    fixture_id: n + 1,
    league: 'Premier League',
    country: 'England'
  )

  rand(1...10).times do
    Tip.create(
      user: user,
      match: match,
      outcome: 'won',
      bet: '1X',
      odd: 1.55,
      mongo_id: '4994jjdfjjkdf-jiriuejd-394ew'
    )
  end
end


# SELECT *, (SELECT COUNT(*) FROM tips WHERE tips.match_id  = m.id) AS tip_count FROM matches AS m ORDER BY tip_count DESC