class User < ApplicationRecord
  has_many :accumulations
  has_many :tips
  has_many :points
  has_many :user_point_counters

  def total_tips
    tips.count
  end

  def total_wins
    tips.won.count
  end

  def total_points
    user_point_counters.sum(:point)
  end

  def monthly_total
    user_point_counters
      .where(awarded_at: Date.current.beginning_of_month...Date.current.end_of_month)
      .sum(:point)
  end

  def monthly_total
    user_point_counters
      .where(awarded_at: Date.current.beginning_of_week...Date.current.end_of_week)
      .sum(:point)
  end
end
