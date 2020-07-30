class FetchRanking < Service::Base
  Rank = Struct.new(:name, :point)
  def perform
    ranking = []
    Point.joins(:user).group('users.name').sum(:value).each do |name, point|
      ranking.push(Rank.new(name, point))
    end

    Service::Result.resolve(ranking.sort { |a, b| b.point <=> a.point })
  end
end