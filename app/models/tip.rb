class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :match

  OUTCOME = [
    PENDING = 'pending',
    WON = 'won',
    LOST = 'lost'
  ]
end
