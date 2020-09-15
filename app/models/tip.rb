class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :match

  scope :won, -> { where(outcome: WON)}
  scope :approved, -> { where.not(approved_at: nil).order(approved_at: :desc) }
  scope :current, -> { where("DATE(created_at) = ?", Date.today) }

  OUTCOME = [
    PENDING = 'pending',
    WON = 'won',
    LOST = 'lost'
  ]

  rails_admin do
    list do 
      field :provider_name
      field :provider_email
      field :match_name
      field :outcome
      field :odd
      field :bet 
    end
    update do 
      field :outcome , :enum do
        enum do
          OUTCOME
        end
      end 
    end
  end

  def won?
    outcome == 'won'
  end

  def lost?
    outcome == 'lost'
  end

  def provider_name
    user.name
  end

  def provider_email
    user.email
  end

  def match_name
    "#{match.home_team_name} vs #{match.away_team_name}"
  end
end
