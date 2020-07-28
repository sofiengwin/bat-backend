class UpdateTip < Service::Update
  attr_reader :tip

  field :outcome
  field :score

  def initialize(tip:, outcome: NOT_SET, score: NOT_SET)
    @tip = tip
    @outcome = outcome
    @score = score
  end

  def perform
    super(tip)
  end
end