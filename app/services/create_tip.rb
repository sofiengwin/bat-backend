class CreateTip < Service::Create
  field :rating
  field :bet, presence: true
  field :bet_category, presence: true
  field :match, presence: true
  field :user, presence: true
  field :odd
  field :outcome
  field :approved_at

  def initialize(rating: nil, bet:, match:, user:, odd: nil, outcome: 'pending', approved_at: nil, bet_category:)
    @rating = rating
    @bet = bet
    @bet_category = bet_category
    @match = match
    @user = user
    @odd = odd
    @outcome = outcome
    @approved_at = approved_at
  end

  def perform
    super(Tip)
  end
end
