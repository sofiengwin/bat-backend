class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :match
  has_many :accumulation_tips, dependent: :delete_all
  has_one :point, as: :pointable

  scope :won, -> { where(outcome: WON)}
  scope :approved, -> { where.not(approved_at: nil) }
  scope :current, -> { where("DATE(created_at) = ?", Time.zone.today) }

  OUTCOME = [
    PENDING = 'pending',
    WON = 'won',
    LOST = 'lost'
  ]

  rails_admin do
    list do
      field :provider_name
      field :match_name
      field :match_country_league
      field :outcome
      field :odd
      field :bet
    end
    update do
      field :match_name do
        formatted_value do
          value.upcase
        end
      end
      field :user
      field :match do
        formatted_value do
          bindings[:view].tag(:img, { :src => bindings[:object].match.home_team_name }) << value
        end
      end
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
    "#{user.email}"
  end

  def match_name
    "#{match.home_team_name} vs #{match.away_team_name}"
  end

  def match_country_league
    "#{match.country} #{match.league}"
  end
end
