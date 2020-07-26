class CreateTip < Service::Create
  field :rating
  field :bet, presence: true
  field :match, presence: true
  field :user, presence: true
  field :mongo_id, presence: true
  field :odd

  def initialize(rating: nil, bet:, match:, user:, odd: nil, mongo_id:)
    @rating = rating
    @bet = bet
    @match = match
    @user = user
    @odd = odd
    @mongo_id = mongo_id
  end

  def perform
    super(Tip)
  end
end