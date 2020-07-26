FactoryBot.define do
  factory :tip do
    user { nil }
    rating { 1 }
    outcome { "MyString" }
    body { "MyString" }
    match { nil }
    bet { '1X'}
  end
end
