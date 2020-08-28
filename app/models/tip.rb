class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :match

  scope :won, -> { where(outcome: WON)}

  OUTCOME = [
    PENDING = 'pending',
    WON = 'won',
    LOST = 'lost'
  ]
end
