FactoryBot.define do
  factory :tip do
    user { nil }
    rating { 1 }
    body { "MyString" }
    match { nil }
    bet { '1X'}
    outcome { 'pending' }
    odd { 2.0 }
  end
end
