class CreateTip < Service::Create
  field :rating
  field :bet, presence: true
  field :match, presence: true
  field :user, presence: true
  field :mongo_id, presence: true
  field :odd
  field :outcome
  field :approved_at

  def initialize(rating: nil, bet:, match:, user:, odd: nil, mongo_id:, outcome: 'pending', approved_at: Time.now)
    @rating = rating
    @bet = bet
    @match = match
    @user = user
    @odd = odd
    @mongo_id = mongo_id
    @outcome = outcome
    @approved_at = approved_at
  end

  def perform
    super(Tip)
  end
end