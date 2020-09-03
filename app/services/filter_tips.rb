class FilterTips < Service::Base
  attr_reader :bet_type, :country, :max_odd, :min_odd, :current_tips

  def initialize(**options)
    @bet_type = options.fetch(:bet_type, nil)
    @country = options.fetch(:country, nil)
    @max_odd = options.fetch(:max_odd, 10)
    @min_odd = options.fetch(:min_odd, 0)
    @current_tips = options.fetch(:current_tips, [])
  end

  def perform
    @tips = filter_already_in_accumulation(filter_by_country(filter_bet_type(filter_by_odd((approved_tips))))).order(created_at: :desc).limit(30)

    Service::Result.resolve(@tips)
  end

  private def approved_tips
    Tip.where.not(approved_at: nil)
  end

  private def filter_by_odd(relation)
    filter_by_max_odd(filter_by_min_odd(relation))
  end

  private def filter_by_max_odd(relation)
    return relation unless max_odd

    relation.where('odd <= ?', max_odd)
  end

  private def filter_by_min_odd(relation)
    return relation unless min_odd

    relation.where('odd >= ?', min_odd)
  end

  private def filter_by_country(relation)
    return relation unless country

    relation.joins(:match).where('matches.country = ?', country)
  end

  private def filter_bet_type(relation)
    return relation unless bet_type

    relation.where(bet: bet_type)
  end

  private def filter_already_in_accumulation(relation)
    return relation if current_tips && current_tips.any?(&:blank?)

    relation.where.not(id: current_tips)
  end
end