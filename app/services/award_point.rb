class AwardPoint < Service::Base
  attr_reader :tip, :current_user_point_counter

  def initialize(tip:)
    @tip = tip
    @current_user_point_counter = UserPointCounter
      .where(user_id: tip.user_id)
      .order(awarded_at: :desc)
      .first
  end

  def perform
    if current_user_point_counter && current_user_point_counter.awarded_at.to_date.cweek == Date.current.cweek
      current_user_point_counter.update(
        point: current_user_point_counter.point + points_being_awarded
      )
      Service::Result.resolve(current_user_point_counter)
    else
      user_point_counter = UserPointCounter.create(
        user_id: tip.user_id,
        awarded_at: Time.current,
        point: points_being_awarded,
      )
      Service::Result.resolve(user_point_counter)
    end
  end

  private

  def points_being_awarded
    10 * tip.odd
  end
end
