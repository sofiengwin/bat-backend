class BetGenerator < Service::Base
  attr_reader :min_odd, :max_odd, :total_odds

  def initialize(min_odd:, max_odd:, total_odds:)
    @min_odd = min_odd || 1.01
    @max_odd = max_odd || 2.00
    @total_odds = total_odds || 10.00
  end

  def perform
    Service::Result.resolve(generated_tips)
  end

  def find_tips
    Tip.where('tips.odd >= ? AND tips.odd <= ?', min_odd, max_odd).order(:odd)
  end

  private def generated_tips
    current_total = 1.00
    find_tips.select do |tip|
      current_total *= tip.odd
      current_total <= total_odds  
    end
  end
end

