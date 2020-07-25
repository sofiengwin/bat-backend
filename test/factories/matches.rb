FactoryBot.define do
  factory :match do
    home_team_name { "MyString" }
    away_team_name { "MyString" }
    score { "MyString" }
    start_at { "2020-07-25 18:21:08" }
    fixture_id { 1 }
    league { "MyString" }
    country { "MyString" }
  end
end
