class CreateAccumulation < Service::Create
  attr_reader :tips
  field :user_id, presence: true
  field :rating
  field :approved_at

  def initialize(tips:, user_id:, rating: nil, approved_at: nil) 
    @tips = tips
    @user_id = user_id
    @rating = rating
    @approved_at = approved_at
  end

  def perform
    super(Accumulation)
      .on_success do |accumulation|
        accumulation.accumulation_tips = tips.map { |tip| AccumulationTip.new(accumulation_id: accumulation.id, tip_id: tip)}
      end
  end
end