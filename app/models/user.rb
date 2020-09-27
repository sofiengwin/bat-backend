class User < ApplicationRecord
  has_many :accumulations
  has_many :tips
  has_many :points

  def total_tips
    accumulations.count
  end

  def total_wins
    accumulations.won.count
  end

  def total_points
    points.sum(:value)
  end
end