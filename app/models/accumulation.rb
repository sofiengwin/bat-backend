class Accumulation < ApplicationRecord
  belongs_to :user
  has_many :accumulation_tips, class_name: 'AccumulationTip', foreign_key: :accumulation_id
  has_many :tips, through: :accumulation_tips
  has_one :point, as: :pointable

  scope :won, -> { where(outcome: WON)}
  scope :current, -> { where("DATE(created_at) = ?", Time.zone.today) }

  OUTCOME = [
    PENDING = 'pending',
    WON = 'won',
    LOST = 'lost'
  ]
end
