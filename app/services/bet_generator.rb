class BetGenerator < Service::Base
  attr_reader :min_odd, :max_odd, :total_odd

  def initialize(min_odd:, max_odd:, total_odd:)
    @min_odd = min_odd
    @max_odd = max_odd
    @total_odd = total_odd
  end

  def perform
    Service::Result.resolve(generated_tips)
  end

  def find_tips
    Tip.where('tips.odd => ? OR tips.odds <= ?', min_odd, max_odd).limit(total_odd.floor)
  end

  private def generated_tips
    current_total = 1
    
    find_tips.collect do |tip|
      current_total += tip.odd * current_total
      current_total <= total_odd
    end
  end
end