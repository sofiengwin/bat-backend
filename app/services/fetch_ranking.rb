class FetchRanking < Service::Base
  Rank = Struct.new(:name, :point)
  RANGES = [
    ['weekly', Time.current.beginning_of_week..Time.current.end_of_week],
    ['monthly', Time.current.beginning_of_month..Time.current.end_of_month],
    ['total', Time.current.beginning_of_year..Time.current.end_of_year],
  ].freeze

  def perform
    ranking = {}
    RANGES.each do |(range_name, range)|
      ranking[range_name] = ranking_for_date_range(range)
    end

    Service::Result.resolve(ranking)
  end

  private

  def ranking_for_date_range(range)
    sql = <<-SQL.squish
      SELECT users.name, SUM(user_point_counters.point) AS total_points FROM user_point_counters
      INNER JOIN users
      ON user_point_counters.user_id = users.id
      WHERE user_point_counters.awarded_at BETWEEN '#{range.begin.to_s}' AND '#{range.end.to_s}'
      GROUP BY users.name
      ORDER BY total_points DESC;
    SQL

    result = ActiveRecord::Base.connection.execute(sql)
    format_result(result)
  end

  def format_result(result)
    result.values.map do |(name, point)|
      Rank.new(name, point)
    end
  end

end
