class Accumulation < ApplicationRecord
  belongs_to :user
  has_many :accumulation_tips, class_name: 'AccumulationTip', foreign_key: :accumulation_id
  has_many :tips, through: :accumulation_tips

  scope :won, -> { where(outcome: WON)}
  scope :current, -> { where("DATE(created_at) = ?", Date.today) }

  OUTCOME = [
    PENDING = 'pending',
    WON = 'won',
    LOST = 'lost'
  ]

  accepts_nested_attributes_for :tips
end
