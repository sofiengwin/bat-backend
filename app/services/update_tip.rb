class UpdateTip < Service::Update
  attr_reader :tip, :score

  field :outcome

  def initialize(tip:, outcome:, score:)
    @tip = tip
    @outcome = outcome
    @score = score
  end

  def perform
    super(tip)
      .on_success { |t| t.match.update(score: score) unless t.match.score }
  end
end