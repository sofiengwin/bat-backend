class Match < ApplicationRecord
  has_many :tips, dependent: :destroy

  rails_admin do
    list do
      field :home_team_name
      field :away_team_name
      field :score
      field :league
      field :country
    end
  end

  def name
    "#{home_team_name} vs #{away_team_name}"
  end
end
